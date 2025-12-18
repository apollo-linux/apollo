#!/bin/bash

set -ouex pipefail

echo "Installing AUR packages..."

# Enable the chaotic AUR for compiled AUR packages
pacman-key --init
pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
pacman-key --lsign-key 3056513887B78AEB

pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' --noconfirm
pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' --noconfirm

tee -a /etc/pacman.conf <<EOL
[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist
EOL

pacman -Sy --noconfirm

# Install our AUR Packages
pacman -S --noconfirm \
    flatpak-git # Install flatpak-git so we can get access to preinstall.
