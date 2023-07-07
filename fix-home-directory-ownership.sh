#!/bin/bash

# Check if script is run as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root"
    exit 1
fi

# Iterate over each user and check home directory ownership and group
echo "Checking and fixing home directory ownership and group..."
while IFS=':' read -r user _ _ home_dir _; do
    if [[ -d "$home_dir" ]]; then
        owner=$(stat -c "%U" "$home_dir")
        group=$(stat -c "%G" "$home_dir")

        if [[ "$owner" != "$user" || "$group" != "$user" ]]; then
            chown "$user:$user" "$home_dir"
            echo "Fixed ownership and group for $home_dir"
        fi
    fi
done < /etc/passwd

echo "Home directory ownership and group check completed."
