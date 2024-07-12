#!/bin/bash


read -p "Enter the file name to share: " file_name


if [[ -f "$file_name" ]]; then
    # Use curl to upload the file
    echo "Uploading $file_name to bashupload.com..."
    curl bashupload.com -T "$file_name"

    # Check if the upload was successful
    if [[ $? -eq 0 ]]; then
        echo "File uploaded successfully."
    else
        echo "Failed to upload the file."
    fi
else
    echo "File not found: $file_name"
fi

