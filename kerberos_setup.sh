#!/bin/bash

# Install MIT Kerberos packages
sudo apt update
sudo apt install krb5-kdc krb5-admin-server

# Configure Kerberos realm and admin server
sudo krb5_newrealm
sudo kadmin.local -q "addprinc admin/admin"
sudo systemctl restart krb5-kdc krb5-admin-server

# Create a principal for a user
sudo kadmin.local -q "addprinc user1"

# Generate a keytab file for the user
sudo kadmin.local -q "xst -k /etc/user1.keytab user1"

# Set proper permissions for the keytab file
sudo chown root:root /etc/user1.keytab
sudo chmod 600 /etc/user1.keytab

echo "Kerberos setup complete!"
