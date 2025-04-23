#!/bin/bash

# File: bash_scripts/update_server.sh

# ===== CONFIG =====
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
PROJECT_DIR="/var/www/CS_421"
LOG_FILE="/var/log/update.log"
WEB_SERVER="apache2"   # Change to 'nginx' if you're using Nginx

# ===== START LOG =====
echo "===== Update started at $TIMESTAMP =====" >> $LOG_FILE

# ===== SYSTEM UPDATE =====
echo "🔄 Updating system packages..." >> $LOG_FILE
sudo apt update >> $LOG_FILE 2>&1
sudo apt upgrade -y >> $LOG_FILE 2>&1

# ===== GIT PULL LATEST CODE =====
echo "📦 Pulling latest code from GitHub repo in $PROJECT_DIR" >> $LOG_FILE
cd "$PROJECT_DIR"

git pull origin main >> $LOG_FILE 2>&1
if [ $? -ne 0 ]; then
    echo "❌ Git pull failed! Update aborted." >> $LOG_FILE
    echo "===== Update failed at $TIMESTAMP =====" >> $LOG_FILE
    echo "" >> $LOG_FILE
    exit 1
else
    echo "✅ Git pull successful." >> $LOG_FILE
fi

# ===== RESTART WEB SERVER =====
echo "🚀 Restarting $WEB_SERVER to apply updates..." >> $LOG_FILE
sudo systemctl restart $WEB_SERVER

if [ $? -eq 0 ]; then
    echo "✅ Web server restarted successfully." >> $LOG_FILE
else
    echo "❌ Failed to restart web server!" >> $LOG_FILE
fi

# ===== END LOG =====
echo "===== Update completed at $(date '+%Y-%m-%d %H:%M:%S') =====" >> $LOG_FILE
echo "" >> $LOG_FILE
