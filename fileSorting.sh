#!/bin/bash

# Prompt the user to enter the name of a directory
read -p "Enter the name of a directory: " curr_dir

# Check if the directory exists
if [ ! -d "$curr_dir" ]; then
    echo "Error: Directory '$curr_dir' does not exist."
    exit 1
fi

# List all the files in the given directory
files_list=$(ls -p "$curr_dir" | grep -v /)

# Check if there are any files in the directory
if [ -z "$files_list" ]; then
    echo "No files found in the directory '$curr_dir'."
    exit 1
fi

# Sort the files
sorted_files=$(echo "$files_list" | sort)

# Create a new directory named "sorted" inside directory
sorted_directory="$curr_dir/sorted"
mkdir -p "$sorted_directory"

# Move each file from the original directory to the "sorted" directory
for file in $sorted_files; do
    mv "$curr_dir/$file" "$sorted_directory/"
done

# Display a success message with the total number of files moved
num_files_moved=$(ls "$sorted_directory" | wc -l)
echo "Successfully moved $num_files_moved files to '$sorted_directory'."
