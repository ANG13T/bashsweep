#!/bin/bash

# Define directory to clean
DIR="$HOME/Downloads"

# Define the number of days
DAYS=30

find "$DIR" -type f -mtime +$DAYS -exec rm -f {} \;

echo "Files older than $DAYS days removed from $DIR."
