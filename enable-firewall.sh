#!/bin/bash
#This script performs the following actions:
#
#Checks if the script is being run as the root user.
#Enables the firewall using the ufw command.
#Retrieves the IP address of the current session using the who command and extracts the IP from the output.
#Allows incoming SSH connections only from the current session IP address using the ufw command.
#Blocks all other incoming connections using the ufw command.
#Allows all outgoing connections using the ufw command.
#Displays the firewall status using the ufw command.
#To use the script, save it to a file (e.g., enable-firewall.sh), make it executable (chmod +x enable-firewall.sh), and run it with root #privileges:
# Check if script is run as root

#The script will enable the firewall, allow incoming SSH connections only from the 
#current session IP address, block all other incoming connections, and allow all 
#outgoing connections. It will then display the firewall status.
#
#Please note that the effectiveness and security of your firewall configuration 
#depend on your specific needs and network environment. Adjust the script to meet 
#your requirements and consult relevant security guidelines for further customization.

if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root"
    exit 1
fi

# Enable the firewall
echo "Enabling the firewall..."
ufw --force enable

# Allow incoming SSH connections from current session IP
current_ip=$(who -u am i | awk '{print $NF}' | sed 's/[()]//g')
echo "Allowing incoming SSH connections from $current_ip..."
ufw allow from $current_ip to any port 22

# Block all other incoming connections
echo "Blocking all other incoming connections..."
ufw default deny incoming

# Allow all outgoing connections
echo "Allowing all outgoing connections..."
ufw default allow outgoing

# Display firewall status
echo "Firewall status:"
ufw status verbose
