#!/bin/bash

# --- Configuration ---
SRC="$HOME/bash-battle-arena" # Folder to backup
BACKUP_DIR="$HOME/backups"    # Main backup folder
mkdir -p "$BACKUP_DIR"

TIMESTAMP=$(date +%Y%m%d_%H%M%S) # Unique timestamp
DEST="$BACKUP_DIR/backup_$TIMESTAMP.tar.gz"

# --- Create backup ---
tar -czf "$DEST" -C "$SRC" .
if [[ $? -eq 0 ]]; then
	echo "Backup created: $DEST"
else
	echo "Backup FAILED!"
	exit 1
fi

# --- Rotate backups (keep last 5) ---
BACKUPS=($(ls -1t "$BACKUP_DIR"/backup_*.tar.gz 2>/dev/null))
for ((i = 5; i < ${#BACKUPS[@]}; i++)); do
	echo "Deleting old backup: ${BACKUPS[i]}"
	rm -f "${BACKUPS[i]}"
done

echo "Backup and rotation completed."
