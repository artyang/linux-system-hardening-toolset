#!/bin/bash

# Update package lists
sudo apt update

# Install dependencies
sudo apt install -y software-properties-common

# Add Suricata PPA
sudo add-apt-repository -y ppa:oisf/suricata-stable

# Update package lists again
sudo apt update

# Install Suricata
sudo apt install -y suricata

echo "Suricata has been installed. You can start configuring it now."
