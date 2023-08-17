#!/bin/bash

# Check if running as root
if [ "$EUID" -ne 0 ]; then
  echo "This script must be run as root"
  exit 1
fi

# Specify the output file
OUTPUT_FILE="/path/to/output/memory_dump.lime"

# Load the LiME module
insmod /path/to/lime.ko "path=$OUTPUT_FILE format=lime"

# Sleep for a moment to allow the module to load and acquire memory
sleep 2

# Unload the LiME module
rmmod lime

echo "Memory dump completed and saved to $OUTPUT_FILE"
