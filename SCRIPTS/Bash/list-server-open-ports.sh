#!/bin/bash

# Open Port Monitoring Script

echo "Listing all open ports on the server..."

sudo netstat -tuln | grep LISTEN
