#!/bin/bash

set -ouex pipefail

echo "Install glibc-locales"
pacman -Sy --noconfirm glibc-locales

echo "Setting the default locale..."
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
