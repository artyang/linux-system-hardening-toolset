#!/bin/bash

# Check if script is run as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root"
    exit 1
fi

# Set the syslog-ng version
syslog_ng_version="3.34.1"  # Replace with the desired syslog-ng version

# Set the download URL
download_url="https://github.com/syslog-ng/syslog-ng/releases/download/syslog-ng-${syslog_ng_version}/syslog-ng-${syslog_ng_version}.tar.gz"

# Set the installation directory
installation_dir="/opt/syslog-ng"  # Replace with your desired installation directory

# Set the configuration file path
config_file="/etc/syslog-ng/syslog-ng.conf"  # Replace with your desired configuration file path

# Download syslog-ng
echo "Downloading syslog-ng..."
wget -O syslog-ng.tar.gz "$download_url"

# Extract syslog-ng
echo "Extracting syslog-ng..."
tar -xf syslog-ng.tar.gz

# Enter the extracted directory
cd "syslog-ng-${syslog_ng_version}" || exit

# Install syslog-ng dependencies
echo "Installing syslog-ng dependencies..."
apt-get update
apt-get install -y build-essential flex bison libevent-dev pkg-config

# Configure and compile syslog-ng
echo "Configuring and compiling syslog-ng..."
./configure --prefix="$installation_dir"
make
make install

# Create the configuration file
echo "Creating the syslog-ng configuration file..."
mkdir -p "$(dirname "$config_file")"
"$installation_dir/sbin/syslog-ng-ctl" --cfgfile="$config_file" --create-dirs

# Configure syslog-ng
echo "Configuring syslog-ng..."
cat <<EOT >> "$config_file"
@version: 3.34

# Example syslog-ng configuration
source s_network {
    tcp(ip(0.0.0.0) port(514));
    udp(ip(0.0.0.0) port(514));
};

destination d_file {
    file("/var/log/syslog-ng/messages");
};

log {
    source(s_network);
    destination(d_file);
};
EOT

# Set ownership and permissions for the configuration file
chown root:root "$config_file"
chmod 644 "$config_file"

# Start syslog-ng service
echo "Starting syslog-ng service..."
"$installation_dir/sbin/syslog-ng"

# Enable syslog-ng service at system startup
echo "Enabling syslog-ng service at system startup..."
systemctl enable syslog-ng.service

echo "syslog-ng installation and configuration completed."
