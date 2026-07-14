#!/usr/bin/env bash
set -euo pipefail

# Add Brave repo and GPG key if not present
if [ ! -f /etc/yum.repos.d/brave-browser.repo ]; then
  sudo dnf install -y dnf-plugins-core
  sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
  sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
  echo "Brave repo added."
fi

# Refresh cache and upgrade
sudo dnf upgrade brave-browser --refresh
