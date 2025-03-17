#!/bin/bash

NGINX_CONF="/etc/nginx/nginx.conf"
TEMP_CONF="/tmp/nginx.conf.tmp"

# Define the required block
REQUIRED_BLOCK="include /etc/nginx/conf.d/*.conf;\n\
\tinclude /etc/nginx/sites-enabled/*;\n\
\tserver {\n\
\t\tlisten 80 default_server;\n\
\t\tlisten [::]:80 default_server;\n\
\t\tserver_name _;\n\
\t\treturn 301 https://\$host\$request_uri;\n\
\t}"

# Find the last closing brace in the file
LAST_CLOSING_BRACE_LINE=$(grep -n "^}" "$NGINX_CONF" | tail -n 1 | cut -d: -f1)

if [[ -n "$LAST_CLOSING_BRACE_LINE" ]]; then
    # Check if the required block is already in the file
    if ! grep -q "listen 80 default_server;" "$NGINX_CONF"; then
        # Insert the required block before the last closing brace
        sudo sed -i "${LAST_CLOSING_BRACE_LINE}i ${REQUIRED_BLOCK}" "$NGINX_CONF"
    fi
    systemctl reload nginx
    echo "nginx.conf updated and Nginx reloaded."
else
    echo "No closing brace found in $NGINX_CONF. Please ensure the file is correctly formatted."
fi
