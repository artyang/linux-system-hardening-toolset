#!/bin/bash

# Function to install Kubernetes using kubeadm
install_kubernetes() {
    echo "Installing Kubernetes..."
    # Update system packages
    sudo apt-get update

    # Install necessary packages
    sudo apt-get install -y apt-transport-https curl

    # Add Kubernetes repository
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
    echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

    # Update again after adding the repository
    sudo apt-get update

    # Install Kubernetes components
    sudo apt-get install -y kubeadm kubelet kubectl

    # Mark Kubernetes packages on hold to avoid unintended upgrades
    sudo apt-mark hold kubeadm kubelet kubectl

    echo "Kubernetes installed successfully!"
}

# Check if the script is run with sudo/root privileges
if [ "$(id -u)" != "0" ]; then
    echo "This script needs to be run with sudo or as the root user."
    exit 1
fi

# Call the function to install Kubernetes
install_kubernetes
