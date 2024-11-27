#!/bin/bash
backup_mysql() {
    DB_NAME="my_database"
    DB_USER="root"
    DB_PASS="password"
    BACKUP_DIR="/backups"
    BACKUP_FILE="$BACKUP_DIR/$DB_NAME-$(date +%Y%m%d).sql.gz"

    mkdir -p $BACKUP_DIR
    echo "Backing up MySQL database: $DB_NAME"
    mysqldump -u $DB_USER -p$DB_PASS $DB_NAME | gzip > $BACKUP_FILE
    echo "Backup completed: $BACKUP_FILE"
}
