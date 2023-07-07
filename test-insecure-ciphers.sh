#!/bin/bash

# Check if the script is run with the correct number of arguments
if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <hostname>"
    exit 1
fi

# Set the hostname or IP address to test
hostname="$1"

# Test for insecure ciphers
echo "Testing for insecure ciphers from SSL certificate..."
openssl s_client -connect "$hostname":443 -cipher LOW:!aNULL:!eNULL:!EXPORT:!DES:!RC4:!MD5:!PSK:!SRP:!CAMELLIA:!DSS:!3DES

echo "Cipher test completed."
