#!/bin/bash

set -ouex pipefail

echo "=== Starting Build for $IMAGE_NAME... ==="

# Enable locales
/ctx/build_files/base/01-locales.sh

# Install the base system packages.
/ctx/build_files/base/02-base.sh

# Install common system tools across all Apollo imgaes
/ctx/build_files/base/03-tools.sh

# Install AUR packages
/ctx/build_files/base/04-aur-packages.sh

# Install base overrides
/ctx/build_files/base/99-base-overrides.sh

echo "=== Base Apollo Buildscripts Complete! ==="

echo "=== Starting GNOME Buildscripts... ==="

# Install GNOME
/ctx/build_files/gnome/01-gnome.sh

# Install GNOME-specific overrides
/ctx/build_files/gnome/99-gnome-overrides.sh

echo "=== Build Complete! ==="
