#!/bin/bash

# Function to install Docker
install_docker() {
    echo "Downloading and installing Docker..."
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    sudo usermod -aG docker "$USER"

    echo "Docker installed successfully!"
    echo "Please log out and log back in or restart your system to apply the user group changes."
}

# Check if the script is run with sudo/root privileges
if [ "$(id -u)" != "0" ]; then
    echo "This script needs to be run with sudo or as the root user."
    exit 1
fi

# Call the function to install Docker
install_docker
