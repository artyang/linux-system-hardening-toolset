#!/bin/bash
# this script performs the following actions:
#
# Set the directory variable to the path of the directory you want to gzip and erase.
# Checks if the directory exists. If the directory doesn't exist, the script exits with an error message.
# Checks if the directory is empty. If the directory is empty, the script exits with an error message.
# Creates a timestamp using the current date and time.
# Constructs the backup file name by appending the timestamp to the directory name.
# Compresses the contents of the directory into a backup file using tar and gzip.
# Removes the contents of the directory using rm -rf.
# Prints a completion message.
# To use the script, save it to a file (e.g., gzip-and-erase.sh), make it executable (chmod +x gzip-and-erase.sh), and run it:
# Set the directory path
# Make sure to replace /path/to/directory with the actual path to the directory you want to gzip and erase.
#
# Please exercise caution when using this script, as it irreversibly erases the contents of the specified directory. Ensure that you have a backup of the directory or its contents if necessary.

directory="/path/to/directory"  # Replace with the path to your directory

# Check if the directory exists
if [[ ! -d "$directory" ]]; then
    echo "Directory not found: $directory"
    exit 1
fi

# Check if the directory is empty
if [[ -z "$(ls -A $directory)" ]]; then
    echo "Directory is empty: $directory"
    exit 1
fi

# Create a timestamp for the backup file
timestamp=$(date +%Y%m%d%H%M%S)

# Create the backup file name
backup_file="${directory}_${timestamp}.tar.gz"

# Compress the directory contents into a backup file
echo "Compressing directory..."
tar -czf "$backup_file" -C "$(dirname $directory)" "$(basename $directory)"

# Remove the directory contents
echo "Erasing directory contents..."
rm -rf "${directory:?}/"*

echo "Directory compression and erasure completed."
