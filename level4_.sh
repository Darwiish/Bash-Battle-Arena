#!/bin/bash

# echo "Level 4: File Manipulation
# echo "Mission: Create a script that copies all .txt files from the Arena directory to a new directory called Backup.

# Create the Backup directory if it doesn't exist
mkdir -p Backup
# Copy all .txt files from Arena to Backup
cp Arena/*.txt Backup/
# Confirmation message
echo "All Files: copied and backed up from Arena to Backup."

echo

SRC="Arena"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
DEST="Backup/Back_${TIMESTAMP}"

if [ -d "$SRC" ]; then

	mkdir -p "$DEST"
	if cp "$SRC"/*.txt "$DEST/" 2>/dev/null; then
		echo "Files copied from $SRC to $DEST."
	else
		echo "Notice: No .txt files found in $SRC."
		rmdir "$DEST" # remove empty backup folder
	fi
else
	echo "Error: $SRC not found."
	exit 1
fi
