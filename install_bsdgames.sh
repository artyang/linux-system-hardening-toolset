#!/bin/bash

# Function to install bsdgames
install_bsdgames() {
    echo "Installing bsdgames..."
    echo "Why? Because all work and no play..."
    sudo apt-get update
    sudo apt-get install -y bsdgames

    echo "bsdgames installed successfully!"
}

# Check if the script is run with sudo/root privileges
if [ "$(id -u)" != "0" ]; then
    echo "This script needs to be run with sudo or as the root user."
    exit 1
fi

# Call the function to install bsdgames
install_bsdgames
