#!/bin/bash

set -ouex pipefail

echo "Installing GNOME..."

# Install a subset of the gnome package group without most of the apps
pacman -S --noconfirm \
    gnome-shell \
    gnome-session \
    gdm \
    gnome-initial-setup \
    xdg-desktop-portal-gnome \
    gnome-control-center \
    gnome-backgrounds \
    gnome-keyring \
    gnome-user-share \
    gnome-remote-desktop \
    rygel \
    tecla \
    grilo-plugins

# Install GNOME applications
pacman -S --noconfirm \
    nautilus \
    ptyxis \
    gnome-disk-utility

# Install GVFS Plugins
pacman -S --noconfirm \
    gvfs-afc \
    gvfs-dnssd \
    gvfs-goa \
    gvfs-google \
    gvfs-gphoto2 \
    gvfs-mtp \
    gvfs-nfs \
    gvfs-onedrive \
    gvfs-smb \
    gvfs-wsdd \

# Install Acessibility Tools
pacman -S --noconfirm \
    orca \
    speech-dispatcher \
    espeakup
