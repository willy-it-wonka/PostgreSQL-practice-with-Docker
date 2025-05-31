#!/bin/bash

CONTAINER_NAME=docker_postgres_1
DB_NAME=postgres_db
DB_USER=admin
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="../backups/backup_$TIMESTAMP.sql"

mkdir -p "$(dirname "$BACKUP_FILE")"

if docker exec $CONTAINER_NAME pg_dump -U $DB_USER $DB_NAME > "$BACKUP_FILE"; 
then echo "Backup completed: $BACKUP_FILE"
else
    echo "Backup FAILED. Check logs."
    rm -f "$BACKUP_FILE"
    exit 1
fi
