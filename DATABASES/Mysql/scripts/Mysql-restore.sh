#!/bin/bash
restore_mysql() {
    DB_NAME="my_database"
    DB_USER="root"
    DB_PASS="password"
    BACKUP_FILE="/backups/my_database.sql.gz"

    echo "Restoring MySQL database: $DB_NAME"
    gunzip < $BACKUP_FILE | mysql -u $DB_USER -p$DB_PASS $DB_NAME
    echo "Database restored!"
}
