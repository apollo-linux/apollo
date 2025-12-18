#!/bin/bash

set -ouex pipefail

# Enable gdm
systemctl enable gdm

# Build the gschema overrides
echo "Build the gschema overrides"
glib-compile-schemas --strict /usr/share/glib-2.0/schemas
