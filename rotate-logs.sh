#!/bin/bash
# The script will rotate and save all log files in the /var/log directory by appending a timestamp to the original file name and creating a new empty log file.
#
# Note that log rotation is an important maintenance task, and the script provided is a basic example. You may need to customize it further to suit your specific log file locations, retention policies, and backup storage requirements.

# Check if script is run as root
# This script performs the following actions:
#
# Checks if the script is being run as the root user.
# Defines the log directory as /var/log (you can change it if needed).
# Creates a timestamp in the format YYYYMMDDHHMMSS for backup file names.
# Loops through each file in the log directory.
# If a file is found, it creates a backup file by appending the timestamp to the original file name.
# The original log file is rotated by moving it to the backup file and then creating a new empty log file.
# Sets appropriate permissions for the new log file.
# Outputs a message for each log file that has been rotated and saved.
# Prints a completion message after all log files have been processed.
# To use the script, save it to a file (e.g., rotate-logs.sh), make it executable (chmod +x rotate-logs.sh), and run it with root privileges:
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

# Define log directory
log_dir="/var/log"

# Create a timestamp for backup
timestamp=$(date +%Y%m%d%H%M%S)

# Loop through log files in the directory
for log_file in "$log_dir"/*; do
    if [[ -f $log_file ]]; then
        # Create backup file name
        backup_file="$log_file.$timestamp"

        # Rotate and save the log file
        mv "$log_file" "$backup_file"
        touch "$log_file"
        chmod 640 "$log_file"

        echo "Rotated and saved log file: $log_file"
    fi
done

echo "Log rotation and saving completed."
