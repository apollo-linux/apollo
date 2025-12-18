#!/bin/bash

set -ouex pipefail

sed -i 's/^NoExtract/#NoExtract/' /etc/pacman.conf
pacman -Sy --noconfirm glibc glibc-locales

echo "Setting the default locale..."
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
