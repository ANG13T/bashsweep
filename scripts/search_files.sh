#!/bin/bash

# INPUT: DIR + KEYWORD
DIR_PATH=${1}
DIR=${DIR_PATH:-"$HOME"}
SEARCH_STRING=${2}

# Check if the specified directory exists
if [ ! -d "$DIR" ]; then
    echo "Error: Directory $DIR does not exist."
    exit 1
fi

# Find and list files containing the search string
grep -rl "$SEARCH_STRING" "$DIR"

echo "Search for $SEARCH_STRING completed."