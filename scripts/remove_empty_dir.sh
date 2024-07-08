#!/bin/bash

DIR_PATH=${1}
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