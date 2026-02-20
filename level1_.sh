#!/bin/bash

# Level 1: The Basics
# Mission: Create a directory named Arena and then inside it, create three files: warrior.txt, mage.txt, and archer.txt.
# Then list the contents of the Arena directory.

# Create the directory
mkdir Arena

# Move into the directory
cd Arena

# Create the three files
touch warrior.txt mage.txt archer.txt

# List the contents to check
ls # List the contents to check

#one-go
# mkdir -p Arena && cd Arena && touch warrior.txt mage.txt archer.txt && ls
