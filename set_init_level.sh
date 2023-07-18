#!/bin/bash

# Define the desired init level
# Runlevel 0: Halt or Shutdown mode. The system is being shut down.
# Runlevel 1: Single-User mode. The system is in a minimal state with a single user (typically root) and a minimal set of services running.
# Runlevel 2: Multi-User mode without networking. The system is in a multi-user state without network services.
# Runlevel 3: Multi-User mode with networking. The system is in a multi-user state with network services enabled. This is typically the default runlevel for most server distributions.
# Runlevel 4: Not used by default. Administrators can define custom runlevels or use Runlevel 4 for their specific needs.
# Runlevel 6: Reboot mode. The system is being rebooted.
init_level="3"  # Change this to the desired init level

# Check if the system uses systemd or sysvinit
if command -v systemctl >/dev/null 2>&1; then
  # Set the init level using systemctl (systemd)
  sudo systemctl isolate runlevel$init_level.target
else
  # Set the init level using init (sysvinit)
  sudo init $init_level
fi
