#!/bin/bash

set -ouex pipefail

echo "Installing base operating system software..."

# Install the core operating system software
pacman -S --noconfirm \
    nano \
    micro \
    vim \
    htop \
    networkmanager \
    sudo

# Install flatpak and distrobox
pacman -S --noconfirm \
    distrobox \
    podman \
    docker \
    flatpak

# Enable Network Manager
systemctl enable NetworkManager.service
