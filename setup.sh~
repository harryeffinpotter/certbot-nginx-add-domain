#!/usr/bin
current_directory="$(pwd)"
echo "Backing up nginx config..."
sudo cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.backup
echo "Moving nginx.conf template to /etc/nginx"
sudo cp -a "${current_directory}"/nginx.conf /etc/nginx/
echo "Moving add_domain to /usr/bin"
sudo cp -a  "${current_directory}"/add_domain.sh /usr/bin/add_domain
echo "Finished setup"
echo -e "\nUsage:\nsudo add-domain subdomain.domain.com <port number of service>\nsudo add-domain test.mydomain.net 6969"
