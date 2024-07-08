#!/bin/bash

DIR=${1}

cd "$DIR" || exit

for FILE in *.*; do
  EXT="${FILE##*.}"
  mkdir -p "$EXT"
  mv "$FILE" "$EXT/"
done

echo "Files organized by extension in $DIR."
