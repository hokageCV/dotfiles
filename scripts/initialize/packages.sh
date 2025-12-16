#!/usr/bin/env bash

# ----------------------------
# Repositories (Fedora)
# ----------------------------

REPOS=(
  "rpmfusion"
  "copr:solopasha/hyprland"
)

# ----------------------------
# Packages
# ----------------------------

PACKAGES=(
  # Base
  git
  stow
  neovim
  zsh
  curl
  wget

  # Dev
  gh
  ripgrep
  fzf

  # Hyprland stack
  hyprland
  hyprlock
  hypridle
  hyprpaper
  xdg-desktop-portal-hyprland

  # UI / tools
  kitty
  waybar
  wofi
  mako

  # Screenshots / media
  grim
  slurp
  swappy
  wl-clipboard
  cliphist
  grimshot

  # lang
  tesseract
  tesseract-langpack-eng
  tesseract-langpack-hin
)
