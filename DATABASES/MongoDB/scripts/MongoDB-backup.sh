backup_mongodb() {
    BACKUP_DIR="/backups/mongo"
    mkdir -p $BACKUP_DIR

    echo "Backing up MongoDB databases..."
    mongodump --out $BACKUP_DIR/backup-$(date +%Y%m%d)
    echo "Backup completed in: $BACKUP_DIR"
}
