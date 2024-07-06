#!/bin/bash

# Prompt user for directory path
read -rp "Enter the directory path to clean (default: $HOME): " DIR_PATH

DIR=${DIR_PATH:-"$HOME"}

# Validate directory existence before proceeding
if [ ! -d "$DIR" ]; then
    echo "Error: Directory '$DIR' not found."
    exit 1
fi

# Clean and print empty directories
find "$DIR" -type d -empty

find "$DIR" -type d -empty -delete

echo "Empty directories removed."