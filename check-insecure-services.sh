#!/bin/bash
# This script performs the following actions:
#
# Checks if the script is being run as the root user.
# Defines a list of insecure services (telnet, rsh, rlogin, rexec, and ftp).
# Loops through each insecure service in the list.
# Checks if the service is active using systemctl is-active.
# If the service is running, it outputs a message indicating that the insecure service is running.
# Prints a completion message after checking all insecure services.
# To use the script, save it to a file (e.g., check-insecure-services.sh), make it executable (chmod +x check-insecure-services.sh), and run it with root privileges:
# Check if script is run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

# Define insecure services
insecure_services=("telnet" "rsh" "rlogin" "rexec" "ftp")

# Loop through insecure services
for service in "${insecure_services[@]}"; do
    if systemctl is-active --quiet $service; then
        echo "Insecure service [$service] is running"
    fi
done

echo "Insecure service check completed."
