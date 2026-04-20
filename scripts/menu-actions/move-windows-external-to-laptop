#!/bin/bash

map_workspace() {
  local ws=$1
  case $ws in
  1) echo 8 ;;
  2) echo 7 ;;
  3) echo 6 ;;
  4) echo 5 ;;
  *) echo "" ;;
  esac
}

echo "Moving windows from external monitor workspaces (1-4) to laptop counterparts..."

hyprctl -j clients | jq -r '.[] | "\(.workspace.id) \(.address)"' | while read -r ws addr; do
  target=$(map_workspace "$ws")
  if [[ -n "$target" ]]; then
    echo "Moving window $addr from WS $ws -> WS $target"
    hyprctl dispatch movetoworkspacesilent "$target,address:$addr"
  fi
done

echo "Done!"

