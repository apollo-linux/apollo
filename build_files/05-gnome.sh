#!/bin/bash

set -ouex pipefail

echo "Installing GNOME..."

pacman -S --noconfirm \
    gnome-shell \
    gnome-session \
    gdm \
    gnome-initial-setup \
    xdg-desktop-portal-gnome \
    nautilus \
    gnome-control-center \
    gnome-backgrounds \
    flatpak \
    ptyxis \
    gnome-disk-utility

systemctl enable gdm
