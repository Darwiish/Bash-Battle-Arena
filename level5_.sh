#!/bin/bash

# BOSS BATTLE - Combining Basics
echo
# Mission:
#1. Create a directory named 'Battlefield'.
#2. Inside Battlefield, create files: knight.txt, sorcerer.txt, rogue.txt.
#3. Check if knight.txt exists; if it does, move it to a new directory called Archive.
#4. List the contents of both Battlefield and Archive.

echo

SRC="Battlefield"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
DEST="Archive/moved_${TIMESTAMP}"

# Create Battlefield directory and files
mkdir -p "$SRC"
touch "$SRC/knight.txt" "$SRC/sorcerer.txt" "$SRC/rogue.txt"

# Create Archive directory
mkdir -p "$DEST"

# Check if knight.txt exists
if [ -f "$SRC/knight.txt" ]; then
	mv "$SRC/knight.txt" "$DEST/"
	echo "Files moved successfully $SRC to $DEST."
else
	echo "Notice: No knight.txt files found in $SRC."
	rmdir "$DEST" 2>/dev/null
fi

# List contents of Battlefield
echo
echo "Battlefield contents:"
ls "$SRC" 2>/dev/null || echo "(empty)"

# List contents of Archive
echo
echo "Archive contents:"
ls "$DEST" 2>/dev/null || echo "(empty)"
