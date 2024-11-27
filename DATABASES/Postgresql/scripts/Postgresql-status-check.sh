check_postgresql_status() {
    echo "Checking PostgreSQL service status..."
    sudo systemctl status postgresql | grep "Active:"
}
