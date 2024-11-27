restore_mongodb() {
    BACKUP_DIR="/backups/mongo/backup-YYYYMMDD"

    echo "Restoring MongoDB databases from $BACKUP_DIR..."
    mongorestore $BACKUP_DIR
    echo "Restore completed!"
}
