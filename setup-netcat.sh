#!/bin/bash

# Check if script is run as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root"
    exit 1
fi

# Set the mode: "listener" or "client"
mode="listener"

# Set the listener port and address (if applicable)
listener_port="1234"
listener_address=""

# Set the target host and port (if applicable)
target_host="example.com"
target_port="80"

# Run netcat based on the mode
if [[ "$mode" == "listener" ]]; then
    echo "Setting up netcat listener..."
    nc -l -p "$listener_port" "$listener_address"
else
    echo "Setting up netcat client..."
    nc "$target_host" "$target_port"
fi
