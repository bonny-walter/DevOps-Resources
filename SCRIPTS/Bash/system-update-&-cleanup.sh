#!/bin/bash

# System Update and Cleanup Script

echo "Updating and cleaning up the system..."

sudo apt update && sudo apt upgrade -y
sudo apt autoremove -y
sudo apt clean

echo "System updated and cleaned up!"
