#!/bin/bash

# Monitor Directory Changes.

DIRECTORY="Arena"
LOG_FILE="change_log.txt"

# Create directory if missing
[ ! -d "$DIRECTORY" ] && mkdir "$DIRECTORY"

# Create some sample files if they don't exist
[ ! -f "$DIRECTORY/system.log" ] && echo "INFO: System started" >"$DIRECTORY/system.log"
[ ! -f "$DIRECTORY/auth.log" ] && echo "INFO: User login" >"$DIRECTORY/auth.log"
[ ! -f "$DIRECTORY/job.log" ] && echo "DEBUG: Job initialized" >"$DIRECTORY/job.log"

echo "Monitoring directory '$DIRECTORY' for changes..."
echo "Changes will be logged to '$LOG_FILE'. Press Ctrl+C to stop."

# Monitor directory recursively using fswatch
fswatch -r "$DIRECTORY" | while read event; do
	if [ -e "$event" ]; then
		# File created or modified
		echo "$(date +'%Y-%m-%d %H:%M:%S') File created/modified: $event" >>"$LOG_FILE"
	else
		# File deleted
		echo "$(date +'%Y-%m-%d %H:%M:%S') File deleted: $event" >>"$LOG_FILE"
	fi
done
