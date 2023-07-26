#!/bin/bash

# Function to install ipcalc
install_ipcalc() {
    echo "Installing ipcalc..."
    sudo apt-get update
    sudo apt-get install -y ipcalc

    echo "ipcalc installed successfully!"
}

# Check if the script is run with sudo/root privileges
if [ "$(id -u)" != "0" ]; then
    echo "This script needs to be run with sudo or as the root user."
    exit 1
fi

# Call the function to install ipcalc
install_ipcalc
