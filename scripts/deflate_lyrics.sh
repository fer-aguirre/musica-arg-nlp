#!/bin/bash

# Make it executable
# chmod +x deflate_lyrics.sh

# Execute it
# ./deflate_lyrics.sh  

# Check if infgen is installed
if ! command -v infgen &> /dev/null; then
    echo "Error: infgen is not installed or not in PATH"
    echo "You might need to install it from: https://github.com/madler/infgen"
    exit 1
fi

# Check if outputs directory exists
if [ ! -d "./outputs" ]; then
    echo "Error: ./outputs directory does not exist"
    exit 1
fi

echo "Running infgen on all .gz files in ./outputs..."

# Check if there are any .gz files
if ! ls ./outputs/*.gz 1> /dev/null 2>&1; then
    echo "No .gz files found in ./outputs"
    exit 1
fi

# Count total files for progress reporting
total_files=$(find ./outputs -name "*.gz" | wc -l)
current_file=0

# Find all .gz files and run infgen on each
for gzfile in ./outputs/*.gz; do
    # Increment counter
    ((current_file++))
    
    # Get just the filename without path or extension
    filename=$(basename "$gzfile" .gz)
    
    echo "[$current_file/$total_files] Processing $filename..."
    
    # Run infgen on the gzip file and redirect output to a file
    if infgen < "$gzfile" > "./outputs/${filename}.infgen" 2>/dev/null; then
        echo "  Success: Created ./outputs/${filename}.infgen"
    else
        echo "  Error processing $filename"
    fi
done

echo "Processing complete. Processed $total_files files."