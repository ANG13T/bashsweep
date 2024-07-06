#!/bin/bash

# Define directories to clean
DIRS=("$HOME")

for DIR in "${DIRS[@]}"; do
  find "$DIR" -type d -empty -delete
done

echo "Empty directories removed."
