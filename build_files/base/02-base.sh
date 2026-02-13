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

# Install spice-vdagent
pacman -S --noconfirm spice-vdagent

# Install Hec's bootc repo for uupd
pacman-key --init
pacman-key --recv-key 5DE6BF3EBC86402E7A5C5D241FA48C960F9604CB --keyserver keyserver.ubuntu.com
pacman-key --lsign-key 5DE6BF3EBC86402E7A5C5D241FA48C960F9604CB

tee -a /etc/pacman.conf <<EOL
[bootc]
SigLevel = Required
Server = https://github.com/hecknt/arch-bootc-pkgs/releases/download/\$repo
EOL

pacman -Sy
pacman -S --noconfirm bootc/uupd