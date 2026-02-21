#!/bin/bash

# Level 6 - Line Counter with Auto File Creation
# Description:
#   This script accepts a filename as an argument and prints the
#   number of lines in that file.
#   If no filename is provided, it shows "No file provided".
#   If the file does not exist, it creates the file with sample text.
#   If the file exists but is unreadable, it shows an error.
#
# Usage:
#   bash level6.sh  file1.txt

# Check if one argument is provided
if [ $# -ne 1 ]; then
	echo "No file provided"
	exit 1
fi

FILENAME="$1"

# Create file with sample text if it doesn't exist
if [ ! -f "$FILENAME" ]; then
	echo "Creating file: $FILE1"
	echo "Read Me Line" >"$FILE1"
	echo "Read again" >>"$FILE1"
	echo "Well Done" >>"$FILE1"
fi

# Check if file exists and is readable
if [ ! -f "$FILENAME" ] || [ ! -r "$FILENAME" ]; then
	echo "File does not exist or is not readable"
	exit 1
fi

# Count lines in the file
LINE_COUNT=$(wc -l <"$FILENAME")

# Print result
echo "The file '$FILENAME' has $LINE_COUNT lines."
