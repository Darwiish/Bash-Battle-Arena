#!/bin/bash

# Level 2: Variables and Loops
# Mission: Create a script that outputs the numbers 1 to 10, one number per line.
echo

# Loop from 1 to 10 using brace expansion
for i in {1..10}; do
	echo "Count: $i"
done

echo

# Loop from 1 to 10 using a counter variable
count=1
while [ $count -le 10 ]; do
	echo "Count: $count"
	((count++))
done
