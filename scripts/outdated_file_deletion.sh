#!/bin/bash

DIR_PATH=${1}
DIR=${DIR_PATH:-"$HOME"}
DAYS=${2}

# Validate directory existence before proceeding
if [ ! -d "$DIR" ]; then
    echo "Error: Directory '$DIR' not found."
    exit 1
fi

find "$DIR" -type f -mtime +$DAYS -exec rm -f {} \;

echo "Files older than $DAYS days removed from $DIR."
