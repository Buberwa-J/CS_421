#!/bin/bash

# File: bash_scripts/health_check.sh

# LOG FILE
LOG_FILE="/var/log/server_health.log"

# Ensure log file exists
sudo touch $LOG_FILE
sudo chmod 666 $LOG_FILE

# Timestamp
echo "===== Health Check @ $(date '+%Y-%m-%d %H:%M:%S') =====" >> $LOG_FILE

# 1. CPU USAGE
CPU_LOAD=$(top -bn1 | grep "load average:" | awk '{print $(NF-2)}' | sed 's/,//')
echo "CPU Load: $CPU_LOAD" >> $LOG_FILE

# 2. MEMORY USAGE
MEM_USAGE=$(free -m | awk '/Mem:/ { printf("%.2f%%", $3/$2 * 100.0) }')
echo "Memory Usage: $MEM_USAGE" >> $LOG_FILE

# 3. DISK USAGE
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}')
echo "Disk Usage: $DISK_USAGE" >> $LOG_FILE

DISK_PERCENT=$(echo $DISK_USAGE | tr -d '%')
if [ "$DISK_PERCENT" -gt 90 ]; then
    echo "⚠️ WARNING: Disk usage is over 90%!" >> $LOG_FILE
fi

# 4. CHECK IF APACHE IS RUNNING
if systemctl is-active --quiet apache2; then
    echo "Apache: Running" >> $LOG_FILE
else
    echo "⚠️ WARNING: Apache is NOT running!" >> $LOG_FILE
fi

# 5. CHECK API ENDPOINTS
API_BASE="http://34.201.147.175/api"

check_endpoint() {
    ENDPOINT=$1
    STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$API_BASE/$ENDPOINT")

    if [ "$STATUS" == "200" ]; then
        echo "Endpoint /$ENDPOINT: OK (200)" >> $LOG_FILE
    else
        echo "⚠️ WARNING: Endpoint /$ENDPOINT returned status $STATUS" >> $LOG_FILE
    fi
}

check_endpoint "students"
check_endpoint "subjects"

echo "===============================================" >> $LOG_FILE
echo "" >> $LOG_FILE
