#!/bin/bash

POSTGRES_SERVICE_NAME="postgres"
DB_NAME="postgres_db"
DB_USER="admin"
DB_PASSWORD="admin123"

PROJECT_ROOT="/home/ja/Pulpit/PostgreSQL-practice-with-Docker"
DOCKER_COMPOSE_FILE="$PROJECT_ROOT/docker/docker-compose.yml"
BACKUP_DIR="$PROJECT_ROOT/backups"
LOG_FILE="$BACKUP_DIR/cron.log"                   
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="$BACKUP_DIR/backup_$TIMESTAMP.sql"

mkdir -p "$BACKUP_DIR"

DOCKER_CMD=$(which docker)
if [ -z "$DOCKER_CMD" ]; then
    echo "$(date): Docker command not found. Please install Docker or check PATH." >> "$LOG_FILE"
    exit 1
fi

DOCKER_COMPOSE_CMD=$(which docker-compose)
if [ -z "$DOCKER_COMPOSE_CMD" ]; then
    echo "$(date): docker-compose command not found. Please install docker-compose or check PATH." >> "$LOG_FILE"
    exit 1
fi

echo "$(date): Starting backup process..." >> "$LOG_FILE"

if "$DOCKER_COMPOSE_CMD" -f "$DOCKER_COMPOSE_FILE" exec -T -e PGPASSWORD="$DB_PASSWORD" "$POSTGRES_SERVICE_NAME" pg_dump -U "$DB_USER" "$DB_NAME" > "$BACKUP_FILE"; then
    echo "$(date): Backup completed: $BACKUP_FILE" >> "$LOG_FILE"
    exit 0
else
    ERROR_MSG="Backup FAILED for database $DB_NAME. Check $BACKUP_FILE (may be empty/incomplete) and system logs."
    echo "$(date): $ERROR_MSG" >> "$LOG_FILE"
    rm -f "$BACKUP_FILE"
    exit 1
fi
