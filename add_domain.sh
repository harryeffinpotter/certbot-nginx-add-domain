#!/bin/bash
source .env
if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo "Not running as root"
    exit 1
fi
cd /etc/nginx
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <domain> <port>"
    exit 1
fi

DOMAIN=$1
PORT=$2


echo "Registering the domain with certbot..."
if ! sudo certbot certonly --non-interactive --nginx -d "${1}" --agree-tos -m "${email}" --force-renewal
then
    echo -e "Certbot failed, attempt runn ing the following line manually and viewing the output:\n\nsudo certbot -d $1\n\n"
    sleep 3
    echo "Do you still want to create config file in /etc/nginx/conf.d (if you plan on manually certifying as suggested) [y/n]?"
    read response
    if [[ ${response} == "N" ]] || [[ ${response} == "n" ]]; then
        exit
    fi
fi
# Read the template and replace placeholders with actual values
CONFIG=$(cat nginx_template.conf | sed "s/__DOMAIN__/$DOMAIN/g" | sed "s/__PORT__/$PORT/g")

# Save thegenerated config to a new file
CONFIG_FILE="/etc/nginx/conf.d/$DOMAIN.conf"
echo "$CONFIG" > $CONFIG_FILE
echo "Config file created at ${CONFIG_FILE}"

echo "Added $1 to config! Restarting service now!"

systemctl stop nginx
systemctl start nginx
exit 0

