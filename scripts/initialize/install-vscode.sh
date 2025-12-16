#!/usr/bin/env bash
set -euo pipefail

REPO_FILE="/etc/yum.repos.d/vscode.repo"
PKG="code"

echo "🔧 Installing Visual Studio Code (Fedora/RHEL)"

# --------------------------------------------------
# 1. Import Microsoft GPG key
# --------------------------------------------------
if rpm -q gpg-pubkey --qf '%{VERSION}-%{RELEASE}\n' | grep -qi microsoft; then
  echo "✔ Microsoft GPG key already imported"
else
  echo "➕ Importing Microsoft GPG key"
  # 🚧 Force IPv4 to avoid TLS reset issues seen on some networks
  curl -4fsSL https://packages.microsoft.com/keys/microsoft.asc | sudo rpm --import -
fi

# --------------------------------------------------
# 2. Add VS Code yum repo
# --------------------------------------------------
if [[ -f "$REPO_FILE" ]]; then
  echo "✔ VS Code repo already exists"
else
  echo "➕ Adding VS Code yum repo"
  sudo tee "$REPO_FILE" >/dev/null <<'EOF'
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
autorefresh=1
type=rpm-md
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOF
fi

# --------------------------------------------------
# 3. Install VS Code
# --------------------------------------------------
if rpm -q "$PKG" &>/dev/null; then
  echo "✔ VS Code already installed"
else
  echo "➕ Installing VS Code"
  sudo dnf install -y "$PKG"
fi

# --------------------------------------------------
# 4. Verify
# --------------------------------------------------
if ! command -v code >/dev/null; then
  echo "❌ VS Code install failed"
  exit 1
fi

echo "✅ VS Code installed successfully"
code --version | head -n 1
