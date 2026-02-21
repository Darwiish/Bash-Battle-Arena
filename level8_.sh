#!/bin/bash

# Search .log files for a word or phrase
# Description:
#   Searches all .log files in a specific directory
#   and prints the filenames containing the search term.

DIRECTORY="Arena"   # Directory to search
SEARCH_TERM="Error" # Word or phrase to search for

echo "INFO: System started" >Arena/system.log
echo "ERROR: Disk full" >>Arena/system.log

echo "INFO: User login" >Arena/auth.log
echo "ERROR: Failed login attempt" >>Arena/auth.log

echo "DEBUG: Cache cleared" >Arena/job.log
echo "INFO: Job completed" >>Arena/job.log

# Check if directory exists
if [ ! -d "$DIRECTORY" ]; then
	echo "Directory '$DIRECTORY' does not exist."
	exit 1
fi

# Search all .log files for the term
grep -il "$SEARCH_TERM" "$DIRECTORY"/*.log 2>/dev/null
