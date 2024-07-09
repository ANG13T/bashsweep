#!/bin/bash

DIR=${1}

# Define file patterns to clean
PATTERNS=("*.tmp" "*.temp" "*.bak" "*~" "*.swp")

# Move files matching patterns to the trash directory and then delete them
for PATTERN in "${PATTERNS[@]}"; do
find "$DIR" -type f -name "$PATTERN" -exec rm -f {} +
done

echo "Temporary files deleted."
