#!/bin/bash

# Define the directory to organize
DIR="$HOME/Documents"

cd "$DIR" || exit

for FILE in *.*; do
  EXT="${FILE##*.}"
  mkdir -p "$EXT"
  mv "$FILE" "$EXT/"
done

echo "Files organized by extension in $DIR."
