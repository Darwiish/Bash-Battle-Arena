#!/bin/bash

CONFIG_FILE="config.txt"

# Check if the config file exists
if [[ ! -f "$CONFIG_FILE" ]]; then
	echo "Error: Config file not found at $CONFIG_FILE"
	exit 1
fi

echo "--- Parsing Configuration File ---"

# Read the config file line by line
while IFS='=' read -r key value; do
	# Skip comments and empty lines
	if [[ -z "$key" || "$key" == \#* ]]; then
		continue
	fi

	# Remove leading/trailing whitespace from key and value
	key=$(echo "$key" | xargs)
	value=$(echo "$value" | xargs)

	# Print the key-value pair
	echo "Key: $key, Value: $value"
done <"$CONFIG_FILE"

echo "--- Done ---"
