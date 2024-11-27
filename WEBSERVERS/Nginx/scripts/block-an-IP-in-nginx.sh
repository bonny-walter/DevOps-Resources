#!/bin/bash

# Block IP Address in Nginx

IP_TO_BLOCK="192.168.1.100"
BLOCK_CONF="/etc/nginx/conf.d/block_ips.conf"

echo "Blocking IP address: $IP_TO_BLOCK"

sudo bash -c "echo 'deny $IP_TO_BLOCK;' >> $BLOCK_CONF"
sudo systemctl reload nginx
echo "IP address $IP_TO_BLOCK blocked in Nginx!"
