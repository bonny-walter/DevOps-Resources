#!/bin/bash
check_mysql_status() {
    echo "Checking MySQL service status..."
    sudo systemctl status mysql | grep "Active:"
}
