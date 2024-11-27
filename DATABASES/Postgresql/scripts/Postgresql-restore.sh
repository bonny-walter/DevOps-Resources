#!/bin/bash
restore_postgresql() {
    DB_NAME="my_database"
    DB_USER="postgres"
    BACKUP_FILE="/backups/my_database.sql.gz"

    echo "Restoring PostgreSQL database: $DB_NAME"
    gunzip < $BACKUP_FILE | psql -U $DB_USER $DB_NAME
    echo "Database restored!"
}
