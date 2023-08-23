#/bin/sh!
systemctl list-units --type=service --state=running
systemctl list-units --type=service --state=inactive
systemctl list-units --type=service --state=failed
