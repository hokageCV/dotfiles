#!/usr/bin/env bash

# ----------------------------
# Repositories (Fedora)
# ----------------------------

REPOS=(
  "rpmfusion"
  "copr:lionheartp/Hyprland"
  "copr:alternateved/keyd"
  "copr:mineiro/satty"
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
  hyprutils
  hyprland-guiutils
  xdg-desktop-portal-hyprland
  qt6ct

  # UI / tools
  kitty
  waybar
  wofi
  mako

  # Screenshots / media
  grim
  slurp
  satty
  wl-clipboard
  cliphist
  grimshot
  hyprpicker
  wf-recorder
  ffmpeg

  # lang
  tesseract
  tesseract-langpack-eng
  tesseract-langpack-hin
)
