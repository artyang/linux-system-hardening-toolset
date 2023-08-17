#!/bin/bash

# Check if running as root
if [ "$EUID" -ne 0 ]; then
  echo "This script must be run as root"
  exit 1
fi

# Set the version of LiME to install
LIME_VERSION="1.9.1"

# Set the directory where LiME source code will be downloaded and compiled
BUILD_DIR="/tmp/lime_build"

# Create the build directory if it doesn't exist
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

# Download LiME source code
wget "https://github.com/504ensicsLabs/LiME/archive/refs/tags/v${LIME_VERSION}.tar.gz"
tar -xzvf "v${LIME_VERSION}.tar.gz"

# Navigate into the LiME source directory
cd "LiME-${LIME_VERSION}"

# Build LiME
make

# Install the LiME module
insmod lime.ko

# Specify the output file for memory dumps
OUTPUT_FILE="/path/to/output/memory_dump.lime"

# Configure LiME to create a memory dump on unload
echo "path=$OUTPUT_FILE format=lime" > /proc/module/lime/parameters/config

# Unload the LiME module to apply the configuration
rmmod lime

echo "LiME installation and configuration completed."
