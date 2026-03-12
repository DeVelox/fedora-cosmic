#!/bin/bash

set -ouex pipefail

# Nightly COSMIC COPR
dnf5 -y copr enable ryanabx/cosmic-epoch
dnf5 -y install cosmic-desktop
dnf5 -y copr disable ryanabx/cosmic-epoch

systemctl disable gdm.service
systemctl enable cosmic-greeter.service

# Extra apps
dnf5 -y install --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release
dnf5 -y install atuin alacritty bat btop dysk eza fd-find fastfetch fish helix ncdu nix-core \
podlet podman-compose quickemu ripgrep starship stow tokei trash-cli ugrep zellij zoxide

# Switch to bootc for updates
systemctl enable bootc-fetch-apply-updates.timer
systemctl disable rpm-ostreed-automatic.timer
sed -i 's/stage/none/' /etc/rpm-ostreed.conf

# Cleanup
dnf5 clean all
rm -rf /tmp/* || true
