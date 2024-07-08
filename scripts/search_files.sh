#!/bin/bash

# Prompt user for directory path
read -rp "Enter the directory path to organize (default: $HOME): " DIR_PATH

DIR=${DIR_PATH:-"$HOME"}

# Check if the specified directory exists
if [ ! -d "$DIR" ]; then
    echo "Error: Directory $DIR does not exist."
    exit 1
fi

# Find and list files containing the search string
grep -rl "$SEARCH_STRING" "$DIR"

echo "Search for $SEARCH_STRING completed."