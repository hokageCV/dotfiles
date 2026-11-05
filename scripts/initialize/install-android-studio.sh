#!/usr/bin/env bash
set -euo pipefail

# Official Google distribution (tarball), installed to /opt.
# Bump AS_VERSION + AS_SHA256 together. Checksums are published per release;
# cross-check against https://github.com/flathub/com.google.AndroidStudio
# (extra-data module) or the release notes page.

AS_VERSION="2026.2.2.8"          # Rabbit 2, stable channel
AS_CODENAME="rabbit2"            # tarball filename suffix
AS_FILE="android-studio-${AS_CODENAME}-linux.tar.gz"
AS_SHA256="b47fdcc0703019618a7afd5ad1822cafc5de66bed984640be2977a0fdb538304"
AS_URL="https://dl.google.com/dl/android/studio/ide-zips/${AS_VERSION}/${AS_FILE}"

INSTALL_DIR="/opt/android-studio"
CACHE="/tmp/${AS_FILE}"
ICON="${INSTALL_DIR}/bin/studio.png"

echo "🔧 Installing Android Studio ${AS_VERSION} (Rabbit 2)"

for bin in curl tar sha256sum; do
  if ! command -v "$bin" >/dev/null; then
    echo "❌ $bin is not installed"
    exit 1
  fi
done

# --------------------------------------------------
# 1. Download and verify
# --------------------------------------------------
if [[ -f "$CACHE" ]] && echo "$AS_SHA256  $CACHE" | sha256sum -c --status -; then
  echo "✔ Cached tarball already verified"
else
  echo "➕ Downloading ${AS_FILE} (~1.5 GB)"
  curl -fL --retry 3 --progress-bar -o "$CACHE" "$AS_URL"
  if ! echo "$AS_SHA256  $CACHE" | sha256sum -c --status -; then
    echo "❌ Checksum mismatch — refusing to install"
    rm -f "$CACHE"
    exit 1
  fi
  echo "✔ Checksum verified"
fi

# --------------------------------------------------
# 2. Extract to /opt (tarball has a top-level android-studio/ dir)
# --------------------------------------------------
echo "➕ Extracting to ${INSTALL_DIR}"
sudo rm -rf "$INSTALL_DIR"
sudo tar -xzf "$CACHE" -C /opt

if [[ ! -x "${INSTALL_DIR}/bin/studio" ]]; then
  echo "❌ Extraction failed — ${INSTALL_DIR}/bin/studio missing"
  exit 1
fi

# --------------------------------------------------
# 3. CLI launcher + desktop entry
# --------------------------------------------------
# Use the native launcher (ELF), not bin/studio.sh — the shell wrapper is only a
# fallback and the IDE nags about it ("consider switching to a native launcher").
sudo ln -sf "${INSTALL_DIR}/bin/studio" /usr/local/bin/android-studio

sudo tee /usr/share/applications/android-studio.desktop >/dev/null <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=Android Studio
GenericName=Android IDE
Comment=Develop Android apps
Exec=${INSTALL_DIR}/bin/studio %f
Icon=${ICON}
Terminal=false
Categories=Development;IDE;
StartupNotify=true
StartupWMClass=jetbrains-studio
EOF

sudo update-desktop-database /usr/share/applications >/dev/null 2>&1 || true

# --------------------------------------------------
# 4. Verify
# --------------------------------------------------
INSTALLED_BUILD="$(sed -n 's/.*"buildNumber"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' "${INSTALL_DIR}/product-info.json" | head -n 1)"

echo "✅ Android Studio installed"
echo "   build   : ${INSTALLED_BUILD:-unknown}"
echo "   binary  : /usr/local/bin/android-studio"
echo "   SDK     : ~/Android/Sdk (set up on first launch, ~3 GB)"
echo
echo "   The IDE ships its own JDK (jbr), so the system JDK 25 does not matter."
echo "   Gradle builds still reject JDK 25 — install java-21-openjdk-devel and"
echo "   point Gradle's JDK at it when you hit that error."

: <<'UNINSTALL_ANDROID_STUDIO'
sudo rm -f /usr/local/bin/android-studio
sudo rm -f /usr/share/applications/android-studio.desktopsudo rm -rf /opt/android-studio
rm -f /tmp/android-studio-rabbit2-linux.tar.gz
# SDK / caches / config stay in place; remove only if you want a clean slate:
#   rm -rf ~/Android/Sdk ~/.android ~/.cache/Google ~/.config/Google
UNINSTALL_ANDROID_STUDIO
