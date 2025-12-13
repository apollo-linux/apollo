#!/bin/bash

set -ouex pipefail

pacman -S --noconfirm \
    nano \
    micro \
    sudo
