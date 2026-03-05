#!/bin/bash

# --- Configuration ---
SRC="$HOME//bash-battle-arena" # Folder to backup
BACKUP_DIR="$HOME/backups"     # Main backup folder
CONFIG_FILE="config.txt"

mkdir -p "$BACKUP_DIR"

# Pause function to wait for user before returning to menu
pause() {
	echo
	read -p "Press Enter to continue..."
}

# Function to display disk space
check_disk_space() {
	echo "===== Disk Space ====="
	df -h
	echo "======================"
}

# Function to show system uptime
show_uptime() {
	echo "===== System Uptime ====="
	uptime -p
	echo "========================="
}

# Backup Arena directory
backup_arena() {

	TIMESTAMP=$(date +%Y%m%d_%H%M%S)
	DEST="$BACKUP_DIR/backup_$TIMESTAMP.tar.gz"

	if [[ ! -d "$SRC" ]]; then
		echo "Error: Source directory does not exist: $SRC"
		return 1
	fi

	tar -czf "$DEST" -C "$SRC" .

	if [[ $? -eq 0 ]]; then
		echo "Backup created successfully: $DEST"
	else
		echo "Error: Backup failed!"
		return 1
	fi

	# Keep only last 3 backups
	BACKUPS=($(ls -1t "$BACKUP_DIR"/backup_*.tar.gz 2>/dev/null))

	for ((i = 3; i < ${#BACKUPS[@]}; i++)); do
		rm -f "${BACKUPS[i]}"
		echo "Old backup removed: ${BACKUPS[i]}"
	done

	echo "Backup completed successfully."
}

# Parse configuration file
parse_config() {

	if [[ ! -f "$CONFIG_FILE" ]]; then
		echo "Error: Config file not found at $CONFIG_FILE"
		return 1
	fi

	echo "===== Config Values ====="

	while IFS='=' read -r key value; do

		if [[ -z "$key" || "$key" == \#* ]]; then
			continue
		fi

		key=$(echo "$key" | xargs)
		value=$(echo "$value" | xargs)

		echo "Key: $key, Value: $value"

	done <"$CONFIG_FILE"

	echo "========================="
}

# Function to display the menu and handle user input
menu() {

	while true; do
		clear
		echo "===== SYSTEM TASKS MENU ====="
		echo "1) Check disk space"
		echo "2) Show system uptime"
		echo "3) Backup Arena directory"
		echo "4) Parse configuration file"
		echo "5) Quit"
		echo "=============================="

		read -p "Enter your choice [1-5]: " choice

		case "$choice" in
		1)
			check_disk_space
			pause
			;;
		2)
			show_uptime
			pause
			;;
		3)
			backup_arena
			pause
			;;
		4)
			parse_config
			pause
			;;
		5)
			echo "Goodbye!"
			break
			;;
		*)
			echo "Invalid option!"
			sleep 1
			;;
		esac
	done
}

# Run the menu function
menu
