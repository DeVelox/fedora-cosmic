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
dnf5 -y install alacritty fish fastfetch podlet podman-compose quickemu starship zellij \
atuin bat btop dysk eza fd-find helix ncdu nix-core ripgrep trash-cli stow tokei ugrep zoxide
dnf5 -y config-manager setopt terra.enabled=false

# Cleanup
dnf5 clean all
rm -rf /tmp/* || true
