#!/bin/bash

# Check if script is run as a non-root user
if [[ $EUID -eq 0 ]]; then
    echo "This script must be run as a non-root user"
    exit 1
fi

# Check if SSH keys already exist
if [[ -f ~/.ssh/id_rsa && -f ~/.ssh/id_rsa.pub ]]; then
    echo "SSH keys already exist in ~/.ssh directory"
    exit 1
fi

# Generate SSH key pair
echo "Generating SSH key pair..."
ssh-keygen -t rsa -b 4096 -N "" -f ~/.ssh/id_rsa

# Set permissions for SSH directory and files
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub

echo "SSH key pair successfully generated"

# Display the public key
echo "Your public key:"
cat ~/.ssh/id_rsa.pub
