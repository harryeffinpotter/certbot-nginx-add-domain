#!/bin/bash
current_directory="$(pwd)"
echo "Backing up your current nginx config to /etc/nginx/nginx.conf.backup, if there are lines you need from it you will have to implement it yourself!"
sudo cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.backup
if ! ls /etc/nginx/nginx.conf > /dev/null; then
    echo "nginx config missing, cant back it up!"
fi
if ! ls /etc/nginx > /dev/null; then
    echo "nginx folder missing, please install nginx"
    exit 0
fi

echo "Moving nginx.conf template to /etc/nginx"
sudo cp -a "${current_directory}"/nginx.conf /etc/nginx/
echo "Moving add_domain to /usr/bin"
sudo cp -a  "${current_directory}"/add_domain.sh /usr/bin/add-domain
while true; do
    echo "What email do you want to use for registering these subdomains?"
    read email
    if [ -n $email ]; then
        echo "email=$email" > "$(pwd)/.env"
        break
    fi
    echo "You didn't enter anything?"
done
echo "Finished setup"
echo -e "\nUsage:\nsudo add-domain subdomain.domain.com <port number of service>\nsudo add-domain test.mydomain.net 6969"

