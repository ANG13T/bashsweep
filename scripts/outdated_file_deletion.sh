#!/bin/bash

DIR_PATH=${1}
DIR=${DIR_PATH:-"$HOME"}
DAYS=${2}

# Validate directory existence before proceeding
if [ ! -d "$DIR" ]; then
    echo "Error: Directory '$DIR' not found."
    exit 1
fi

if [ "$DAYS" -eq 0 ]; then
  find "$DIR" -type f -mtime 0 -exec rm -f {} \;
else
  find "$DIR" -type f -mtime +$DAYS -exec rm -f {} \;
fi

echo "Files older than $DAYS days removed from $DIR."
