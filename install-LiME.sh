#!/bin/bash

# Update package lists
sudo apt update

# Install required dependencies
sudo apt install build-essential linux-headers-$(uname -r) git

# Clone LiME repository
git clone https://github.com/504ensicsLabs/LiME.git

# Navigate to LiME directory
cd LiME/src/

# Build LiME
make

# Install LiME module
sudo insmod lime-$(uname -r).ko

# Check if module is loaded
lsmod | grep lime

# Create a directory to store the dumped memory
mkdir ~/lime_dump

echo "LiME has been installed and loaded. You can now proceed to capture memory using 'lime-forensics -r memory.dump'."
