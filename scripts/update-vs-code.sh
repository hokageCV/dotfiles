#!/usr/bin/env bash
set -euo pipefail

# https://code.visualstudio.com/docs/setup/linux#_rhel-fedora-and-centos-based-distributions

# Add Microsoft repo and GPG key if not present
if [ ! -f /etc/yum.repos.d/vscode.repo ]; then
  sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
  sudo tee /etc/yum.repos.d/vscode.repo >/dev/null <<'EOF'
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
autorefresh=1
type=rpm-md
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOF
  echo "VS Code repo added."
fi

# Refresh cache and upgrade
sudo dnf upgrade code --refresh
