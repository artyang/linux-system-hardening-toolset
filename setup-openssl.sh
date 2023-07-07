#!/bin/bash

# Check if script is run as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root"
    exit 1
fi

# Install OpenSSL
echo "Installing OpenSSL..."
apt-get update
apt-get install -y openssl

# Generate a self-signed certificate
echo "Generating a self-signed certificate..."
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/server.key -out /etc/ssl/certs/server.crt

# Set permissions for the private key
chmod 600 /etc/ssl/private/server.key

# Display the generated certificate information
echo "Self-signed certificate generated:"
openssl x509 -in /etc/ssl/certs/server.crt -noout -text

echo "OpenSSL setup completed."
This script performs the following actions:

Checks if the script is being run as the root user.
Installs OpenSSL using apt-get.
Generates a self-signed certificate using openssl req.
Sets permissions for the private key file.
Displays the generated certificate information using openssl x509.
To use the script, save it to a file (e.g., setup-openssl.sh), make it executable (chmod +x setup-openssl.sh), and run it with root privileges:

bash
Copy code
sudo ./setup-openssl.sh
The script will install OpenSSL, generate a self-signed certificate, set permissions for the private key, and display the generated certificate information.

Please note that this script assumes a Debian-based Linux system and uses specific commands for package management and OpenSSL operations. Adjustments may be required for different Linux distributions or variations in the package management system and OpenSSL commands.






