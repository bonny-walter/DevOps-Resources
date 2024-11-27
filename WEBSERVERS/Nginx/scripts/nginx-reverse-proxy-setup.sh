#!/bin/bash

# Nginx Reverse Proxy Setup

UPSTREAM_SERVER="http://localhost:8080"
DOMAIN="example.com"

echo "Setting up Nginx reverse proxy for $DOMAIN..."

CONF_FILE="/etc/nginx/sites-available/$DOMAIN"
sudo cat <<EOF > $CONF_FILE
server {
    listen 80;
    server_name $DOMAIN www.$DOMAIN;

    location / {
        proxy_pass $UPSTREAM_SERVER;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
    }
}
EOF

# Enable the site and reload Nginx
sudo ln -s $CONF_FILE /etc/nginx/sites-enabled/
sudo systemctl reload nginx
echo "Reverse proxy for $DOMAIN set up and enabled!"
