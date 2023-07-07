#!/bin/bash

# Check if script is run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

# Update and upgrade the system
echo "=== Updating System ==="
apt update -y
apt upgrade -y
echo ""

# Disable unused services
echo "=== Disabling Unused Services ==="
services=("telnet" "ftp" "rsh" "rlogin" "rexec")
for service in "${services[@]}"; do
    systemctl disable $service
    systemctl stop $service
    echo "Disabled and stopped $service"
done
echo ""

# Enable and configure the firewall (ufw)
echo "=== Configuring Firewall ==="
apt install ufw -y
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw enable
ufw status
echo ""

# Set strong password policies
echo "=== Setting Password Policies ==="
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sed -i 's/#PermitEmptyPasswords no/PermitEmptyPasswords no/' /etc/ssh/sshd_config
sed -i 's/#PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
systemctl restart sshd
echo ""

# Configure user accounts and access
echo "=== Configuring User Accounts ==="
password_policy="/etc/pam.d/common-password"
sed -i 's/pam_cracklib.so/pam_unix.so obscure sha512 minlen=8/' $password_policy
chage --maxdays 90 root
chage --maxdays 90 user1
chage --maxdays 90 user2
echo ""

# Enable automatic security updates
echo "=== Enabling Automatic Security Updates ==="
apt install unattended-upgrades -y
dpkg-reconfigure --priority=low unattended-upgrades
echo ""

# Disable root login via SSH
echo "=== Disabling Root Login via SSH ==="
sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
systemctl restart sshd
echo ""

# Harden sysctl settings
echo "=== Hardening Sysctl Settings ==="
sysctl_file="/etc/sysctl.conf"
echo "
# Disable IPv6
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1

# Ignore ICMP broadcasts
net.ipv4.icmp_echo_ignore_broadcasts = 1

# Disable IP forwarding
net.ipv4.ip_forward = 0

# Enable secure ICMP redirects
net.ipv4.conf.all.secure_redirects = 1
net.ipv4.conf.default.secure_redirects = 1

# Disable source packet routing
net.ipv4.conf.all.accept_source_route = 0
net.ipv4.conf.default.accept_source_route = 0

# Enable TCP SYN cookies
net.ipv4.tcp_syncookies = 1

# Enable protection against IP Spoofing attacks
net.ipv4.conf.all.rp_filter = 1
net.ipv4.conf.default.rp_filter = 1" >> $sysctl_file
sysctl -p
echo ""

# Configure file permissions
echo "=== Configuring File Permissions ==="
chmod 644 /etc/passwd
chmod 000 /etc/shadow
chmod 644 /etc/group
chmod 600 /boot/grub/grub.cfg
echo ""

echo "=== System Hardening Complete ==="
