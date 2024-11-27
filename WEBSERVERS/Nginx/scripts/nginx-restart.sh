#!/bin/bash

# Restart Nginx Server

echo "Restarting Nginx web server..."
sudo systemctl restart nginx
echo "Nginx status:"
sudo systemctl status nginx | grep "Active:"
