#!/bin/bash

# Disk Space Report

# -------------------------------
# Configuration
# -------------------------------
LOG_FILE="$HOME/bash-exercises/logs/disk_backup.log" # Path to store logs
DISK_THRESHOLD=80                                    # Alert threshold in percentage
DIR_TO_CHECK="/"                                     # Directory/filesystem to monitor
ALERT_EMAIL="devOps@example.com"                     # Optional: email to receive alerts

mkdir -p "$(dirname "$LOG_FILE")"
# -------------------------------
# Functions
# -------------------------------
log_message() {
	local MESSAGE=$1
	echo "$(date +"%Y-%m-%d %H:%M:%S") - $MESSAGE" | tee -a "$LOG_FILE"
}

check_disk_space() {
	# Get disk usage percentage of the directory
	local DISK_USAGE=$(df "$DIR_TO_CHECK" | awk 'NR==2 {gsub("%",""); print $5}')

	if [ "$DISK_USAGE" -ge "$DISK_THRESHOLD" ]; then
		log_message "ALERT: Disk usage is at ${DISK_USAGE}%, exceeding the threshold of $DISK_THRESHOLD%."
		# Optional email alert
		# echo "Disk usage alert: $DISK_USAGE% on $DIR_TO_CHECK" | mail -s "Disk Alert: $DIR_TO_CHECK" "$ALERT_EMAIL"
		return 1 # High disk usage
	else
		log_message "Disk usage is at ${DISK_USAGE}%, within safe limits."
		return 0 # Safe
	fi
}

# -------------------------------
# Main Script
# -------------------------------
if ! check_disk_space; then
	log_message "Insufficient disk space. Exiting."
	exit 1
fi

log_message "Backup script completed successfully."
