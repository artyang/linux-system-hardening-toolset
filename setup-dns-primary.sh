#!/bin/bash

# Check if script is run as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root"
    exit 1
fi

# Install BIND
echo "Installing BIND..."
apt-get update
apt-get install -y bind9 bind9utils

# Set the DNS server IP address
dns_server_ip="192.168.0.10"  # Replace with your desired DNS server IP address

# Configure named.conf.local
echo "Configuring named.conf.local..."
cat <<EOT > /etc/bind/named.conf.local
zone "example.com" {
    type master;
    file "/etc/bind/db.example.com";
    allow-transfer { none; };
    allow-query { any; };
};
EOT

# Create the zone file
echo "Creating zone file..."
cat <<EOT > /etc/bind/db.example.com
\$ORIGIN example.com.
\$TTL 1d
@       IN      SOA     ns1.example.com. admin.example.com. (
                           2023070701 ; Serial
                           3h         ; Refresh after 3 hours
                           1h         ; Retry after 1 hour
                           1w         ; Expire after 1 week
                           1d )       ; Negative caching TTL of 1 day

        IN      NS      ns1.example.com.
        IN      A       $dns_server_ip

ns1     IN      A       $dns_server_ip
www     IN      A       192.168.0.20  # Replace with your desired IP address for the www subdomain
EOT

# Restart BIND service
echo "Restarting BIND service..."
systemctl restart bind9

echo "DNS primary server setup completed."
