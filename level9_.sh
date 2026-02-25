#!/bin/bash

# Monitor Directory Changes

DIRECTORY="Arena"
LOG_FILE="$DIRECTORY/change_log.txt" # Log inside Arena

# Create directory if missing
[ ! -d "$DIRECTORY" ] && mkdir "$DIRECTORY"

# Create some sample files if they don't exist
[ ! -f "$DIRECTORY/system.log" ] && echo "INFO: System started" >"$DIRECTORY/system.log"
[ ! -f "$DIRECTORY/auth.log" ] && echo "INFO: User login" >"$DIRECTORY/auth.log"
[ ! -f "$DIRECTORY/job.log" ] && echo "DEBUG: Job initialized" >"$DIRECTORY/job.log"

# Create the log file if it doesn't exist
[ ! -f "$LOG_FILE" ] && echo "$(date +'%Y-%m-%d %H:%M:%S') - change_log.txt created" >"$LOG_FILE"

echo "Monitoring directory '$DIRECTORY' for changes..."
echo "Changes will be logged to '$LOG_FILE'. Press Ctrl+C to stop."

# Function to log events
log_event() {
	echo "$(date +'%Y-%m-%d %H:%M:%S') - $1" >>"$LOG_FILE"
}

# Monitor directory recursively
fswatch -0 -r "$DIRECTORY" | while read -d "" event; do
	if [ -e "$event" ]; then
		log_event "File created/modified: $event"
	else
		log_event "File deleted or moved: $event"
	fi
done
