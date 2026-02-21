#!/bin/bash

# Sort .txt files in a directory by size
# Description:
#   Lists all .txt files in the specified directory
#   and sorts them from smallest to largest by file size.

echo "Archer ready for battle" >Arena/archer.txt
echo "Mage is casting powerful spells" >Arena/mage.txt
echo "Warrior is swinging sword" >Arena/warrior.txt

DIRECTORY="Arena"

# Check if directory exists
if [ ! -d "$DIRECTORY" ]; then
	echo "Directory '$DIRECTORY' does not exist."
	exit 1
fi

# Find all .txt files, list with human-readable sizes, sort by size, and display
find "$DIRECTORY" -type f -name "*.txt" -exec ls -lh {} + |
	sort -k 5,5 -h |
	awk '{ print $5, $9 }'
