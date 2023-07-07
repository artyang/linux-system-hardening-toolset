#!/bin/bash

# Check if script is run as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root"
    exit 1
fi

# Set password complexity requirements
password_length=8     # Minimum password length
require_lowercase=1   # Require at least one lowercase letter
require_uppercase=1   # Require at least one uppercase letter
require_numeric=1     # Require at least one numeric character
require_special=1     # Require at least one special character

# Get the list of all users
users=$(cut -d: -f1 /etc/passwd)

# Iterate over each user and set password complexity requirements
echo "Setting up password complexity for all users..."
for user in $users; do
    passwd_options=""
    
    # Set minimum length requirement
    passwd_options+=" -x $password_length"
    
    # Set lowercase requirement
    if [[ $require_lowercase -eq 1 ]]; then
        passwd_options+=" -d"
    fi
    
    # Set uppercase requirement
    if [[ $require_uppercase -eq 1 ]]; then
        passwd_options+=" -u"
    fi
    
    # Set numeric requirement
    if [[ $require_numeric -eq 1 ]]; then
        passwd_options+=" -o"
    fi
    
    # Set special character requirement
    if [[ $require_special -eq 1 ]]; then
        passwd_options+=" -s"
    fi
    
    # Apply password complexity requirements
    passwd -n 1 $user
    chage $passwd_options $user
done

echo "Password complexity setup completed."
