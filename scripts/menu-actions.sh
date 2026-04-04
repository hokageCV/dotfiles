#!/usr/bin/env bash
set -euo pipefail

ACTIONS_DIR="$HOME/dotfiles/scripts/menu-actions"

declare -A ACTIONS=(
  ["Brightness Decrease"]="brightness-down"
  ["Brightness Increase"]="brightness-up"
  ["OCR"]="ocrshot"
  ["Close All Programs"]="close-all-programs"
  ["Toggle Presentation Mode"]="toggle-presentation-mode"
  ["Shutdown"]="shutdown"
)

choice=$(
  printf "%s\n" "${!ACTIONS[@]}" |
    sort |
    wofi --dmenu --prompt "Scripts" \
      --matching fuzzy --insensitive
)

[[ -z "$choice" ]] && exit 0

exec "$ACTIONS_DIR/${ACTIONS[$choice]}"
