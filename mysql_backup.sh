#!/bin/bash
# ---------------------------------------------------------
# MySQL Backup Script for VPS
# Author: Gift Balogun
# Portfolio: https://giftbalogun.name.ng
# GitHub: https://github.com/giftbalogun
# Description: This script automates MySQL database backups
# on Debian-based VPS systems with optional compression.
# License: MIT (c) 2024 Gift Balogun. All rights reserved.
# ---------------------------------------------------------

# CONFIGURATION
#----------------------------------------
MYSQL_USER=""       # MySQL Username
MYSQL_PASSWORD=""   # MySQL Password
DAYS_TO_KEEP=5      # Set to 0 to keep backups forever
GZIP=0             # 1 = Enable compression, 0 = No compression
BACKUP_PATH="/root/backup/mysql"

#----------------------------------------
# FUNCTIONS
#----------------------------------------

# Ensure backup directory exists
ensure_backup_directory() {
  if [ ! -d "$BACKUP_PATH" ]; then
    mkdir -p "$BACKUP_PATH"
    echo "[INFO] Created backup directory: $BACKUP_PATH"
  fi
}

# Get list of databases
fetch_databases() {
  mysql -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW DATABASES;" | tr -d "|" | grep -v -E "Database|information_schema|performance_schema|mysql|sys"
}

# Perform database backup
backup_database() {
  local db_name=$1
  local timestamp=$(date +"%Y-%m-%d_%H-%M-%S")

  if [ "$GZIP" -eq 1 ]; then
    echo "[INFO] Backing up database: $db_name (compressed)"
    mysqldump -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" --databases "$db_name" | gzip -c > "$BACKUP_PATH/$timestamp-$db_name.sql.gz"
  else
    echo "[INFO] Backing up database: $db_name (uncompressed)"
    mysqldump -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" --databases "$db_name" > "$BACKUP_PATH/$timestamp-$db_name.sql"
  fi

  if [ $? -eq 0 ]; then
    echo "[SUCCESS] Backup completed: $db_name"
  else
    echo "[ERROR] Failed to backup database: $db_name"
  fi
}

# Remove old backups
cleanup_old_backups() {
  if [ "$DAYS_TO_KEEP" -gt 0 ]; then
    echo "[INFO] Removing backups older than $DAYS_TO_KEEP days..."
    find "$BACKUP_PATH"/* -mtime +"$DAYS_TO_KEEP" -exec rm {} \;
    echo "[INFO] Cleanup completed."
  fi
}

#----------------------------------------
# EXECUTION
#----------------------------------------

echo "--------------------------------------------------------"
echo "      MySQL Backup Script - Copyright © 2024 Gift Balogun"
echo "--------------------------------------------------------"

ensure_backup_directory
databases=$(fetch_databases)

for db in $databases; do
  backup_database "$db"
done

cleanup_old_backups

echo "[INFO] MySQL Backup Process Completed Successfully!"
