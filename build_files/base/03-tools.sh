#!/bin/bash

set -ouex pipefail

# Install flatpak and distrobox, along with container runtimes
pacman -S --noconfirm \
    distrobox \
    podman \
    docker \

# Install pre-included terminal applications
pacman -S --noconfirm \
    bash-completion \
    fish \
    zsh \
    hyfetch \
    fastfetch \
    nano \
    micro \
    vim \
    htop \
    just \
    gum

# Install some developer tools
pacman -S --noconfirm \
    gcc \
    git \
    android-tools \
    ydotool

# Install nerd font symbols out of the box \
pacman -S --noconfirm \
    ttf-nerd-fonts-symbols \

pacman -S --noconfirm \
    flatpak
