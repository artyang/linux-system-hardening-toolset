#!/bin/bash
#
# This script performs the following actions:
#
# Checks if the script is being run as the root user.
# Checks if SELinux is already disabled. If it is, the script exits.
# Checks if the SELinux package is installed. If it is not, an error message is displayed.
# Disables SELinux by setting the permissive mode using the setenforce command.
# Modifies the /etc/selinux/config file to set SELINUX=disabled for future reboots.
# To use the script, save it to a file (e.g., disable-selinux.sh), make it executable (chmod +x disable-selinux.sh), and run it with root privileges:

# Check if script is run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

# Check if SELinux is already disabled
if [[ $(getenforce) == "Disabled" ]]; then
    echo "SELinux is already disabled"
    exit 0
fi

# Check if SELinux package is installed
if ! command -v sestatus >/dev/null 2>&1; then
    echo "SELinux package is not installed. Please install it and try again."
    exit 1
fi

# Disable SELinux
setenforce 0
sed -i 's/^SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config

echo "SELinux is now disabled. A system reboot is recommended for the change
