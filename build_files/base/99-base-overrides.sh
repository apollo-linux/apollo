#!/bin/bash

set -ouex pipefail

# Enable wheel group for sudo
echo "%wheel ALL=(ALL) ALL" > /etc/sudoers.d/wheel-group
chmod 0400 /etc/sudoers.d/wheel-group
visudo -c -f /etc/sudoers.d/wheel-group

# Enable Network Manager & systemd-resolved
systemctl enable NetworkManager.service
systemctl enable systemd-resolved.service

# Disable systemd's firstboot
systemctl mask systemd-firstboot.service

# Make sure that brew can be used with bash
echo "source /etc/profile.d/brew.sh" | tee -a /etc/bash.bashrc

# Make sure terminals use starship by default
echo "eval "$(starship init bash)"" | tee -a /etc/bash.bashrc