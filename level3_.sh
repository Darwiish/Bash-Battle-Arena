#!/bin/bash

#echo "Level 3: Conditional Statements"
#echo "Mission: Write a script that checks if a file named hero.txt exists in the Arena directory."
#echo "If it does, print Hero found!; otherwise, print Hero missing!."
echo

TARGET_FILE="Arena/hero.txt"

echo "$TARGET_FILE"

if [ -f "$TARGET_FILE" ]; then
	echo "Hero: found"
else
	echo "Hero: missing"
fi

#[ -f "$TARGET_FILE" ] && echo "found!" || echo "File: Missing"
