#!/bin/bash

set -ouex pipefail

# Set the os-release info
/ctx/00-os-release.sh

# Install the base system packages.
/ctx/03-base.sh

# Install GNOME
/ctx/05-gnome.sh
