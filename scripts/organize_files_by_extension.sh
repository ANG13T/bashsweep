#!/bin/bash

# Prompt user for directory path
read -rp "Enter the directory path to organize (default: $HOME): " DIR_PATH

DIR=${DIR_PATH:-"$HOME"}

cd "$DIR" || exit

for FILE in *.*; do
  EXT="${FILE##*.}"
  mkdir -p "$EXT"
  mv "$FILE" "$EXT/"
done

echo "Files organized by extension in $DIR."
