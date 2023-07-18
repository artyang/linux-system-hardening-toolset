#!/bin/bash

# Define the username for which you want to retrieve the command history
username="your_username"

# Switch to the specified user
sudo -u "$username" bash << EOF

# Retrieve the last 100 commands executed by the user
history_commands=\$(history | grep -E "^\s*[0-9]+\s+" | tail -n 100)

# Display the command history
echo "Last 100 commands executed by user: $username"
echo "-------------------------------------"
echo "\$history_commands"

EOF
