#!/bin/bash

# Define the directory you want to compress
source_dir="/path/to/your/source/directory"

# Define the name for the compressed tarball
output_file="compressed_directory.tar.gz"

# Navigate to the parent directory of the source directory
cd "$(dirname "$source_dir")"

# Create a compressed tarball of the subdirectory
tar -czvf "$output_file" "$(basename "$source_dir")"
