#!/bin/bash

# ===============================
# Backup Script with Rotation
# ===============================

# --- Configuration ---
SRC="$HOME/bash-battle-arena"     # Directory to backup
BACKUP_DIR="$HOME/backups"        # Main backup folder
MAX_BACKUPS=5                     # Number of backups to keep
LOG_FILE="$BACKUP_DIR/backup.log" # Log file

# --- Prepare ---
mkdir -p "$BACKUP_DIR"
TIMESTAMP=$(date +'%Y%m%d_%H%M%S')
DEST="$BACKUP_DIR/backup_$TIMESTAMP.tar.gz"

log() {
	echo "$(date +"%Y-%m-%d %H:%M:%S") - $1" | tee -a "$LOG_FILE"
}

# --- Start Backup ---
log "Starting backup of: $SRC"

if [ ! -d "$SRC" ]; then
	log "ERROR: Source directory does not exist: $SRC"
	exit 1
fi

# Create compressed backup
tar -czf "$DEST" -C "$SRC" .
if [ $? -eq 0 ]; then
	log "Backup created successfully: $DEST"
else
	log "ERROR: Backup failed!"
	exit 1
fi

# --- Backup Rotation ---
log "Performing backup rotation (keeping last $MAX_BACKUPS backups)..."

# Get backups sorted by newest first
BACKUPS=($(ls -1t "$BACKUP_DIR"/backup_*.tar.gz 2>/dev/null))

if [[ ${#BACKUPS[@]} -gt MAX_BACKUPS ]]; then
	for old_backup in "${BACKUPS[@]:$MAX_BACKUPS}"; do
		rm -f "$old_backup"
		log "Deleted old backup: $old_backup"
	done
else
	log "No old backups to delete. Total backups: ${#BACKUPS[@]}"
fi

log "Backup and rotation completed successfully."
