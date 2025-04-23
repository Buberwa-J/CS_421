#!/bin/bash

# File: bash_scripts/backup_api.sh

# ===== CONFIG =====
TIMESTAMP=$(date +%F)
BACKUP_DIR="/home/ubuntu/backups"
API_DIR="/var/www/CS_421"
DB_NAME="student_subjects"
DB_USER="root"
DB_PASS="your_password"
LOG_FILE="/var/log/backup.log"

# ===== START LOG =====
echo "===== Backup started at $(date '+%Y-%m-%d %H:%M:%S') =====" >> $LOG_FILE

# ===== CREATE BACKUP DIRECTORY IF IT DOESN'T EXIST =====
mkdir -p $BACKUP_DIR

# ===== BACKUP API PROJECT =====
API_BACKUP_FILE="$BACKUP_DIR/api_backup_$TIMESTAMP.tar.gz"
tar -czf "$API_BACKUP_FILE" "$API_DIR" 2>> $LOG_FILE

if [ $? -eq 0 ]; then
    echo "✅ Project backup created: $API_BACKUP_FILE" >> $LOG_FILE
else
    echo "❌ Failed to backup project directory!" >> $LOG_FILE
fi

# ===== BACKUP DATABASE =====
DB_BACKUP_FILE="$BACKUP_DIR/db_backup_$TIMESTAMP.sql"
mysqldump -u $DB_USER -p$DB_PASS $DB_NAME > "$DB_BACKUP_FILE" 2>> $LOG_FILE

if [ $? -eq 0 ]; then
    echo "✅ Database backup created: $DB_BACKUP_FILE" >> $LOG_FILE
else
    echo "❌ Failed to export database!" >> $LOG_FILE
fi

# ===== DELETE OLD BACKUPS (>7 days) =====
find "$BACKUP_DIR" -type f -mtime +7 -exec rm {} \; >> $LOG_FILE
echo "🧹 Cleaned backups older than 7 days." >> $LOG_FILE

# ===== END LOG =====
echo "===== Backup completed =====" >> $LOG_FILE
echo "" >> $LOG_FILE
