#!/bin/bash

# SSL Certificate Expiry Check Script

DOMAIN="bonnyzone.site"  # Replace with your domain
echo "Checking SSL certificate expiry for $DOMAIN..."

EXPIRY_DATE=$(echo | openssl s_client -servername $DOMAIN -connect $DOMAIN:443 2>/dev/null | \
    openssl x509 -noout -enddate | cut -d= -f2)

echo "SSL certificate for $DOMAIN expires on: $EXPIRY_DATE"
