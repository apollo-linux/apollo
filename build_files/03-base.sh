#!/bin/bash

set -ouex pipefail

echo "Installing base operating system software..."

pacman -S --noconfirm \
    nano \
    micro \
    vim \
    htop \
    bash \
    sudo
