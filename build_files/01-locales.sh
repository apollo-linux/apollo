#!/bin/bash

set -ouex pipefail

sed -i 's/^NoExtract/#NoExtract/' /etc/pacman.conf
pacman -Sy --noconfirm glibc

echo "Enabling locales"
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
sed -i 's/^#\(.*\.UTF-8\)/\1/' /etc/locale.gen
locale-gen
