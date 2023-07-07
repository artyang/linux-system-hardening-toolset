#!/bin/bash

# Check if script is run as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root"
    exit 1
fi

# Install Snort and required dependencies
echo "Installing Snort and dependencies..."
apt-get update
apt-get install -y snort snort-rules-default

# Configure Snort
echo "Configuring Snort..."
cp /etc/snort/snort.conf /etc/snort/snort.conf.original

# Enable Snort rules
sed -i 's|# include \$RULE\_PATH/include \$RULE\_PATH|' /etc/snort/snort.conf

# Enable unified2 output
sed -i 's|output unified2|# output unified2|' /etc/snort/snort.conf
sed -i '/# output unified2/a output unified2: filename snort.log, limit 128' /etc/snort/snort.conf

# Configure network interface
interface=$(ip -o -4 route show to default | awk '{print $5}')
sed -i "s|INTERFACE\=eth0|INTERFACE\=$interface|" /etc/snort/snort.conf

# Start Snort service
systemctl enable snort
systemctl start snort

echo "Snort installation and configuration completed."
