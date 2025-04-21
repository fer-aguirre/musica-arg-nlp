#!/bin/bash

# Make it executable
# chmod +x compress_lyrics.sh

# Execute it
# ./compress_lyrics.sh  

# Check if outputs directory exists
if [ ! -d "./outputs" ]; then
    echo "Error: ./outputs directory does not exist"
    exit 1
fi

echo "Compressing all files in ../outputs with maximum compression..."

# Find all regular files in the directory and compress them
# Using -9 flag for maximum compression
find ./outputs -type f -not -name "*.gz" -exec gzip -9 -k {} \;

echo "Compression complete. All files have been compressed with .gz extension."
