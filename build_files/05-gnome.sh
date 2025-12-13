#!/bin/bash

set -ouex pipefail

echo "Installing GNOME..."

pacman -S --noconfirm \
    gnome-shell \
    gnome-session \
    gdm \
    gnome-initial-setup \
    xdg-desktop-portal-gnome \
    gnome-control-center \
    gnome-backgrounds

# Install GNOME applications
pacman -S --noconfirm \
    nautilus \
    ptyxis \
    gnome-disk-utility

# Install Acessibility Tools
pacman -S --noconfirm \
    orca \
    speech-dispatcher \
    espeakup

systemctl enable gdm
