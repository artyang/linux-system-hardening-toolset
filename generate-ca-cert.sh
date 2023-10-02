#!/bin/bash

# Function to generate a Certificate Authority signing certificate
generate_ca_certificate() {
    read -p "Enter a common name for the Certificate Authority (CA): " ca_common_name

    # Generate a private key for the CA
    openssl genpkey -algorithm RSA -out "${ca_common_name}_ca.key" -aes256

    # Generate a self-signed root CA certificate
    openssl req -x509 -new -key "${ca_common_name}_ca.key" -out "${ca_common_name}_ca.crt" -days 3650 -subj "/CN=${ca_common_name}"

    echo "CA signing certificate generated: ${ca_common_name}_ca.crt"
}

# Run the function to generate the CA signing certificate
generate_ca_certificate

exit 0
