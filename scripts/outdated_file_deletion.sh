#!/bin/bash

read -rp "Enter the directory to perform operation (default: $HOME): " DIR_PATH

DIR=${DIR_PATH:-"$HOME"}

read -rp "Enter the number of days (default: 30): " DAYS_INPUT

# Use default value if no input is given
DAYS=${DAYS_INPUT:-30}

# Validate directory existence before proceeding
if [ ! -d "$DIR" ]; then
    echo "Error: Directory '$DIR' not found."
    exit 1
fi

find "$DIR" -type f -mtime +$DAYS -exec rm -f {} \;

echo "Files older than $DAYS days removed from $DIR."
