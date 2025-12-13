#!/bin/bash

set -ouex pipefail

echo "Installing base operating system software..."

# Install core operating system software
pacman -S --noconfirm \
    networkmanager \
    sudo \
    power-profiles-daemon \
    gamemode

# Enable wheel group for sudo
echo "%wheel ALL=(ALL) ALL" > /etc/sudoers.d/wheel-group
chmod 0400 /etc/sudoers.d/wheel-group
visudo -c -f /etc/sudoers.d/wheel-group

# Install flatpak and distrobox
pacman -S --noconfirm \
    distrobox \
    podman \
    docker \
    flatpak

# Install pre-included terminal applications
pacman -S --noconfirm \
    starship \
    fish \
    zsh \
    hyfetch \
    fastfetch \
    nano \
    micro \
    vim \
    htop \
    git

# Install spice-vdagent
pacman -S --noconfirm spice-vdagent

# Enable Network Manager
systemctl enable NetworkManager.service
