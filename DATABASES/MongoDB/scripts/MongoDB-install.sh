#!/bin/bash

# install gnupg and curl
sudo apt-get install gnupg curl

# Import the public key
curl -fsSL https://www.mongodb.org/static/pgp/server-8.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-8.0.gpg \
   --dearmor
   

# Create the list file for Ubuntu 24.04 
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg ] https://repo.mongodb.org/apt/ubuntu noble/mongodb-org/8.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-8.0.list

# Reload the package database
sudo apt-get update

# Install MongoDB Community Server.
sudo apt-get install -y mongodb-org

# Start , verify status and enable  MongoDB 
sudo systemctl start mongod
sudo systemctl status mongod
sudo systemctl enable mongod

# Begin using MongoDB.

# Start a mongosh session on the same host machine as the mongod. 
# You can run mongosh without any command-line options to connect to a mongod that is running on your localhost with default port 27017

mongosh

# Stop MongoDB.

# stop the mongod process by issuing the following command:

# sudo service mongod stop


# Remove Packages.

# Remove any MongoDB packages that you had previously installed.

# sudo apt-get purge mongodb-org*


# Remove Data Directories.

# Remove MongoDB databases and log files.

# sudo rm -r /var/log/mongodb
# sudo rm -r /var/lib/mongodb


