#!/bin/bash

set -ouex pipefail

echo "Installing base operating system software..."

# Copy /ctx/system_files into /
pacman -S --noconfirm \
    rsync

rsync -rvK /ctx/system_files/ /

# Activate the rechunker group fix
chmod +x /usr/bin/rechunker-group-fix
systemctl enable rechunker-group-fix.service

# Install drivers
pacman -S --noconfirm \
    mesa \
    vulkan-radeon \
    vulkan-intel

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

# Install pre-included terminal applications
pacman -S --noconfirm \
    starship \
    bash-completion \
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

# Enable Network Manager & systemd-resolved
systemctl enable NetworkManager.service
systemctl enable systemd-resolved.service

# Disable systemd's firstboot
systemctl mask systemd-firstboot.service
