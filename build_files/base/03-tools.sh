#!/bin/bash

set -ouex pipefail

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