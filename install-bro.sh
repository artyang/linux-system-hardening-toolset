#!/bin/bash

# Update package lists
sudo apt update

# Install dependencies
sudo apt install -y cmake make gcc g++ flex bison libpcap-dev libssl-dev python3 python3-pip swig zlib1g-dev

# Clone Bro repository
git clone --recursive https://github.com/zeek/zeek.git

# Navigate to Zeek source directory
cd zeek

# Configure Zeek
./configure

# Build Zeek
make

# Install Zeek
sudo make install

echo "Zeek has been installed. You can start using it now."
