#!/bin/bash

# Check if script is run as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root"
    exit 1
fi

# Get the list of all users
users=$(cut -d: -f1 /etc/passwd)

# Iterate over each user and set password expiration
echo "Setting up password rotation for all users..."
for user in $users; do
    chage --maxdays 90 "$user"
done

echo "Password rotation setup completed."
