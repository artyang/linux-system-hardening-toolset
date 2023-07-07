#!/bin/bash
# The script will disable the firewall and display the firewall status.
#
# Please note that disabling the firewall can leave your system vulnerable 
# to network attacks. Ensure that you have alternative security measures in 
# place before disabling the firewall, and consider the implications for your 
# specific system and network environment.
# Check if script is run as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root"
    exit 1
fi

# Disable the firewall
echo "Disabling the firewall..."
ufw --force disable

# Display firewall status
echo "Firewall status:"
ufw status verbose
