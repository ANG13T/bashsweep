#!/bin/bash

# Define directories to clean
DIRS=("$HOME")

# Define file patterns to clean
PATTERNS=("*.tmp" "*.temp" "*.bak" "*~" "*.swp")

# Define the trash directory
TRASH_DIR="$HOME/Trash"

# Create the trash directory if it doesn't exist
mkdir -p "$TRASH_DIR"

# Move files matching patterns to the trash directory and then delete them
for DIR in "${DIRS[@]}"; do
  for PATTERN in "${PATTERNS[@]}"; do
    find "$DIR" -type f -name "$PATTERN" -exec mv {} "$TRASH_DIR" \;
  done
done

echo "Temporary files moved to $TRASH_DIR."
