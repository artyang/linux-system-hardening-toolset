#!/bin/bash

# Define SSH connection details
ssh_user="your_username"      # Replace with your SSH username
ssh_host="remote_host"        # Replace with the remote host IP or domain name
ssh_port="22"                 # Replace with the SSH port (default is 22)
local_port="8080"             # Replace with the local port you want to tunnel
remote_port="80"              # Replace with the remote port you want to tunnel

# Start the SSH tunnel
echo "Setting up SSH tunnel..."
ssh -N -L "$local_port:localhost:$remote_port" "$ssh_user@$ssh_host" -p "$ssh_port"
