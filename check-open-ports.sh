#!/bin/bash
# The script will display the open ports and the corresponding processes using those ports.
#
# Please note that the script relies on the netstat and lsof commands to gather information about 
# open ports and the associated processes. Ensure that these commands are available on your system, 
# and adjust the script as needed for different Linux distributions or variations in the command output.
# Checks if the script is being run as the root user.
# Uses netstat command to retrieve a list of open TCP ports.
# Extracts the port numbers from the netstat output using awk.
# Sorts the port numbers in ascending order and removes duplicate entries using sort and uniq.
# Loops through each open port.
# Uses lsof command to find the corresponding process using the specified port.
# Extracts the process name from the lsof output using awk.
# Prints the port number and the corresponding process name.
# To use the script, save it to a file (e.g., check-open-ports.sh), make it executable (chmod +x check-open-ports.sh), and run it with root privileges:
# Check if script is run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

# Get list of open ports
open_ports=$(netstat -tuln | awk '/^tcp/ {print $4}' | awk -F ':' '{print $NF}' | sort -n | uniq)

# Loop through open ports and find corresponding processes
for port in $open_ports; do
    process=$(lsof -i :$port | awk 'NR==2 {print $1}')
    echo "Port $port is used by $process"
done
