#!/bin/bash

# Boss Battle 2 Script with Victory_Archive
# Description: Creates battle files, logs actions, and archives victorious files

# Directories
DIR="Arena_Boss"
ARCHIVE="Victory_Archive"
LOG="$DIR/change_log.txt"

# Ensure directories exist
mkdir -p "$DIR" "$ARCHIVE"

# Clear previous log
>"$LOG"

# Enable safe globbing (no files = empty array)
shopt -s nullglob

# Function to get timestamp
timestamp() {
	date +'%Y-%m-%d %H:%M:%S'
}

# Create 5 battle files with random lines (10-20)
for i in {1..5}; do
	FILE="$DIR/file$i.txt"
	>"$FILE"                    # Clear file
	LINES=$((RANDOM % 11 + 10)) # Random 10-20 lines

	for ((j = 1; j <= LINES; j++)); do
		if ((RANDOM % 4 == 0)); then
			echo "Line $j: Victory!" >>"$FILE"
		else
			echo "Line $j: Battle continues..." >>"$FILE"
		fi
	done

	echo "$(timestamp) Created $FILE with $LINES lines" >>"$LOG"
done

# Display files sorted by size
echo
echo "Files in $DIR sorted by size:"
ls -lhS "$DIR"

# Move files containing 'Victory' to Victory_Archive
echo
echo "Checking for 'Victory' in files..."
VICTORY_COUNT=0
REMAINING_COUNT=0

for FILE in "$DIR"/*.txt; do
	if grep -q "Victory" "$FILE"; then
		mv "$FILE" "$ARCHIVE/"
		echo "$(basename "$FILE") contains 'Victory' and moved to $ARCHIVE."
		echo "$(timestamp) $FILE moved to $ARCHIVE" >>"$LOG"
		((VICTORY_COUNT++))
	else
		echo "$(basename "$FILE") has no 'Victory'."
		echo "$(timestamp) No 'Victory' in $FILE" >>"$LOG"
		((REMAINING_COUNT++))
	fi
done

# Summary
echo
echo "Victory files moved: $VICTORY_COUNT"
echo "Remaining files in arena: $REMAINING_COUNT"
echo "All actions logged to $LOG"
