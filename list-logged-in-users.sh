#!/bin/bash
# The script will display a list of all users who have logged into the system.
#
#Please note that the script relies on the last command, which reads from the system's login records. The output may not include currently active sessions or users who have recently logged out. Additionally, the script assumes that the login records are stored in the default system location. Adjustments may be needed depending on the specific Linux distribution and configuration.
#This script performs the following actions:
#
#Checks if the script is being run as the root user.
#Uses the last command to retrieve the login sessions.
#Filters out the lines starting with "reboot", "wtmp", and empty lines.
#Extracts the usernames from the filtered output using awk.
#Sorts the usernames in alphabetical order and removes duplicate entries using sort and uniq.
#Prints the list of unique usernames.
#To use the script, save it to a file (e.g., list-logged-in-users.sh), make it executable (chmod +x list-logged-in-users.sh), and run it with root privileges:
# Check if script is run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

# Retrieve unique user login sessions from the last command
users=$(last | awk '!/^reboot|^wtmp|^$/ {print $1}' | sort | uniq)

# Print the list of users
echo "Users who have logged in:"
echo "$users"
