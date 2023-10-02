#!/bin/bash

# Function to generate client certificate
generate_client_certificate() {
    read -p "Enter client's common name (e.g., client1): " client_common_name
    read -p "Enter client's organization name: " client_organization

    # Generate a private key for the client
    openssl genpkey -algorithm RSA -out "${client_common_name}.key"

    # Create a certificate signing request (CSR)
    openssl req -new -key "${client_common_name}.key" -out "${client_common_name}.csr" -subj "/CN=${client_common_name}/O=${client_organization}"

    # Sign the CSR (you can replace ca.crt and ca.key with your CA's certificate and key)
    openssl x509 -req -in "${client_common_name}.csr" -CA ca.crt -CAkey ca.key -CAcreateserial -out "${client_common_name}.crt" -days 365

    echo "Client certificate generated: ${client_common_name}.crt"
}

# Run the function to generate the client certificate
generate_client_certificate

exit 0
