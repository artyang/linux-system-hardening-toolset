#!/bin/bash

# Check if script is run as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root"
    exit 1
fi

# Set the download URL for the latest stable release of nmap
download_url="https://nmap.org/dist/nmap-7.91.tar.bz2"

# Set the directory to download and extract nmap
download_dir="/tmp/nmap"

# Create the download directory
mkdir -p "$download_dir"

# Download nmap
echo "Downloading nmap..."
curl -o "$download_dir/nmap.tar.bz2" -L "$download_url"

# Extract nmap
echo "Extracting nmap..."
tar -xf "$download_dir/nmap.tar.bz2" -C "$download_dir"

# Enter the nmap directory
cd "$download_dir/nmap-"* || exit

# Configure and compile nmap
echo "Configuring and compiling nmap..."
./configure
make

# Install nmap
echo "Installing nmap..."
make install

# Clean up
echo "Cleaning up..."
cd ..
rm -rf "$download_dir"

# Verify nmap installation
echo "Verifying nmap installation..."
nmap --version

echo "Nmap installation and verification completed."
