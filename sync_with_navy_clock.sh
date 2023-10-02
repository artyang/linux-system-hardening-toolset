#!/bin/bash
# https://www.time.gov/
# Function to synchronize time with the U.S. Navy atomic clock
sync_with_navy_atomic_clock() {
    #   navy_atomic_server="time.nist.gov" #  NIST Time Server
    navy_atomic_server="tick.usno.navy.mil" # U.S. Navy atomic clock server
    #   navy_atomic_server="tock.usno.navy.mil" # U.S. Navy atomic clock server
    #   navy_atomic_server="ntp2.usno.navy.mil" # U.S. Navy atomic clock server
    #   navy_atomic_server="ntp1.usno.navy.mil" # U.S. Navy atomic clock server
      

    echo "Synchronizing time with the U.S. Navy atomic clock..."
    if sudo timedatectl set-ntp false; then
        sudo ntpdate -u "$navy_atomic_server"
        sudo timedatectl set-ntp true
        echo "Time synchronization successful!"
    else
        echo "Failed to synchronize time. Please check your system settings."
    fi
}

# Check if ntpdate is installed
if ! command -v ntpdate &>/dev/null; then
    echo "ntpdate command not found. Please install it to use this script."
    exit 1
fi

# Check if the script is run with sudo/root privileges
if [ "$(id -u)" != "0" ]; then
    echo "This script needs to be run with sudo or as the root user."
    exit 1
fi

# Call the function to sync time with the U.S. Navy atomic clock
sync_with_navy_atomic_clock
