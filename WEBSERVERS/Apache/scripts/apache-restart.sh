#!/bin/bash

# Restart Apache Server

echo "Restarting Apache web server..."
sudo systemctl restart apache2
echo "Apache status:"
sudo systemctl status apache2 | grep "Active:"
