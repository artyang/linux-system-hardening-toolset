#!/bin/bash

# Define the desired init level
init_level="3"  # Change this to the desired init level

# Check if the system uses systemd or sysvinit
if command -v systemctl >/dev/null 2>&1; then
  # Set the init level using systemctl (systemd)
  sudo systemctl isolate runlevel$init_level.target
else
  # Set the init level using init (sysvinit)
  sudo init $init_level
fi
