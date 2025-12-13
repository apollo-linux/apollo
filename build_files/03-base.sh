#!/bin/bash

set -ouex pipefail

echo "Installing base operating system software..."

# Install core operating system software
pacman -S --noconfirm \
    networkmanager \
    sudo \
    power-profiles-daemon \
    gamemode

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
    htop

# Enable Network Manager
systemctl enable NetworkManager.service
