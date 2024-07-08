#!/bin/bash

# Prompt user for directory path
read -rp "Enter the directory path to clean (default: $HOME): " DIR_PATH

DIR=${DIR_PATH:-"$HOME"}

# Define file patterns to clean
PATTERNS=("*.tmp" "*.temp" "*.bak" "*~" "*.swp")

# Move files matching patterns to the trash directory and then delete them
for DIR in "${DIRS[@]}"; do
  for PATTERN in "${PATTERNS[@]}"; do
    find "$DIR" -type f -name "$PATTERN" -exec rm -f {} +
  done
done

echo "Temporary files deleted."
