#!/bin/bash

# Update package list and upgrade existing packages
sudo apt update && sudo apt upgrade -y

# Install Python and pip (if not already installed)
sudo apt install -y python3 python3-pip

# Install Checkov using pip
pip3 install checkov

# Verify installation
checkov --version

echo "Checkov has been installed successfully."
