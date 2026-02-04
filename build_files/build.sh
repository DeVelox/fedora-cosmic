#!/bin/bash

set -ouex pipefail

# Nightly COSMIC COPR
dnf5 -y copr enable ryanabx/cosmic-epoch
dnf5 -y install cosmic-desktop
dnf5 -y copr disable ryanabx/cosmic-epoch

systemctl disable gdm.service
systemctl enable cosmic-greeter.service

# Extra apps
dnf5 -y install fish alacritty quickemu podman-compose

# Cleanup
dnf5 clean all
rm -rf /tmp/* || true
