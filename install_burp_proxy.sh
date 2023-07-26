#!/bin/bash

# Function to download and install Burp Proxy
install_burp_proxy() {
    # Specify the download URL of the Burp Suite community version
    burp_download_url="https://portswigger.net/burp/releases/download?product=community&version=2021.8.2&type=linux"

    # Create a temporary directory for the installation
    temp_dir=$(mktemp -d)

    echo "Downloading Burp Suite..."
    wget -q --show-progress -O "$temp_dir/burp_community_linux.tar.gz" "$burp_download_url"

    if [ $? -eq 0 ]; then
        echo "Download successful!"
    else
        echo "Failed to download Burp Suite. Please check your internet connection or the download URL."
        exit 1
    fi

    echo "Extracting Burp Suite..."
    tar -xzf "$temp_dir/burp_community_linux.tar.gz" -C "$temp_dir"

    echo "Installing Burp Suite..."
    sudo mkdir -p /opt/burpsuite
    sudo mv "$temp_dir/burpsuite_community"/* /opt/burpsuite
    sudo ln -s /opt/burpsuite/BurpSuiteCommunity /usr/local/bin/burpsuite

    echo "Cleaning up temporary files..."
    rm -rf "$temp_dir"

    echo "Burp Proxy installed successfully!"
}

# Check if the script is run with sudo/root privileges
if [ "$(id -u)" != "0" ]; then
    echo "This script needs to be run with sudo or as the root user."
    exit 1
fi

# Call the function to download and install Burp Proxy
install_burp_proxy
