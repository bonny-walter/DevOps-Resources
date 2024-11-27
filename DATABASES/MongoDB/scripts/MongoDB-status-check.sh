check_mongodb_status() {
    echo "Checking MongoDB service status..."
    sudo systemctl status mongod | grep "Active:"
}
