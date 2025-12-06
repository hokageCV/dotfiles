#!/usr/bin/env bash

# Save current workspace
CUR_WS=$(hyprctl -j workspaces | jq -r '.[] | select(.focused==true).id')

wait_for_class() {
  local class="$1"
  local tries=0
  local win=""
  while [ $tries -lt 80 ]; do
    win=$(hyprctl -j clients | jq -r --arg cls "$class" '.[] | select(.class == $cls) | .address' | head -n1)
    if [ -n "$win" ] && [ "$win" != "null" ]; then
      printf '%s' "$win"
      return 0
    fi
    tries=$((tries + 1))
    sleep 0.1
  done
  return 1
}

launch_on_ws() {
  local ws="$1"
  local class="$2"
  shift 2
  local cmd=("$@")

  hyprctl dispatch workspace "$ws"
  sleep 0.06

  "${cmd[@]}" &

  WIN_ADDR=$(wait_for_class "$class") || WIN_ADDR=""
  if [ -n "$WIN_ADDR" ]; then
    hyprctl dispatch movetoworkspace "$ws,address:$WIN_ADDR"
  fi

  hyprctl dispatch workspace "$CUR_WS"
  sleep 0.02
}

# =======================================================
# Launch main apps
# =======================================================

launch_on_ws 1 "Code" code
launch_on_ws 2 "md.obsidian.Obsidian" flatpak run md.obsidian.Obsidian
launch_on_ws 4 "Brave-browser" brave-browser --profile-directory="Profile 1"

# =======================================================
# launch slack
# =======================================================

# 1. Switch to workspace 3
hyprctl dispatch workspace 3
sleep 0.1

# 2. Launch Brave new window with Slack
brave-browser --profile-directory="Profile 1" --new-window "https://app.slack.com/client/T0328LRTJ/G08CBSX6V" &

# 3. Wait for Slack Brave window to appear
SLACK_WIN=$(wait_for_class "Brave-browser")
