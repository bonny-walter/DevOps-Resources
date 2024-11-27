#!/bin/bash
backup_postgresql() {
    DB_NAME="my_database"
    DB_USER="postgres"
    BACKUP_DIR="/backups"
    BACKUP_FILE="$BACKUP_DIR/$DB_NAME-$(date +%Y%m%d).sql.gz"

    mkdir -p $BACKUP_DIR
    echo "Backing up PostgreSQL database: $DB_NAME"
    pg_dump -U $DB_USER $DB_NAME | gzip > $BACKUP_FILE
    echo "Backup completed: $BACKUP_FILE"
}
