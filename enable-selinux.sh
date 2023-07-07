#!/bin/bash
#
# This script performs the following actions:
#
# Checks if the script is being run as the root user.
# Checks if SELinux is already enabled. If it is, the script exits.
# Checks if the SELinux package is installed. If it is not, an error message is displayed.
# Enables SELinux by setting the enforcing mode using the setenforce command.
# Modifies the /etc/selinux/config file to set SELINUX=enforcing for future reboots.
# To use the script, save it to a file (e.g., enable-selinux.sh), make it executable (chmod +x enable-selinux.sh), and run it with root privileges:

# Check if script is run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

# Check if SELinux is already enabled
if [[ $(getenforce) == "Enforcing" ]]; then
    echo "SELinux is already enabled"
    exit 0
fi

# Check if SELinux package is installed
if ! command -v sestatus >/dev/null 2>&1; then
    echo "SELinux package is not installed. Please install it and try again."
    exit 1
fi

# Enable SELinux
setenforce 1
sed -i 's/^SELINUX=disabled/SELINUX=enforcing/' /etc/selinux/config

echo "SELinux is now enabled. A system reboot is recommended for the changes
