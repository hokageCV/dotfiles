#!/bin/bash
#
# monitor-power-watch.sh - Detects external monitor power cut and moves windows to laptop
#
# DETECTION METHOD:
#   'ddcutil detect' checks the HDMI monitor via I2C
#   - Power ON:  Output contains "VCP version: 2.2"
#   - Power OFF: Output contains "x37 is unresponsive"
#
# CRON: Runs every minute automatically
# LOCK: 5-minute cooldown to prevent duplicate triggers

SCRIPT_PATH="/home/hokage/dotfiles/scripts/monitor-power-watch.sh"
MOVE_SCRIPT="/home/hokage/dotfiles/scripts/move-windows-external-to-laptop.sh"
LOCK_FILE="/tmp/monitor-power-cut-triggered.lock"
LOG_FILE="/tmp/monitor-power-watch.log"
LOCK_TIMEOUT=300

log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

check_monitor_power() {
  local ddc_output
  ddc_output=$(ddcutil detect 2>&1)

  if echo "$ddc_output" | grep -q "x37 is unresponsive"; then
    return 0 # Power is OFF
  else
    return 1 # Power is ON
  fi
}

run_action() {
  log "Power cut detected! Moving windows..."

  # Get Hyprland signature
  local hypr_dir="/run/user/$(id -u)/hypr"
  local hypr_sig=""
  if [[ -d "$hypr_dir" ]]; then
    hypr_sig=$(ls -1 "$hypr_dir" 2>/dev/null | head -1)
  fi

  log "Using HYPRLAND_INSTANCE_SIGNATURE=$hypr_sig"

  if [[ -x "$MOVE_SCRIPT" ]]; then
    DISPLAY=:0 XDG_RUNTIME_DIR=/run/user/$(id -u) HYPRLAND_INSTANCE_SIGNATURE="$hypr_sig" bash "$MOVE_SCRIPT"
  else
    log "ERROR: Move script not found: $MOVE_SCRIPT"
    exit 1
  fi

  touch "$LOCK_FILE"
  log "Action complete"
}

setup_cron() {
  # Get current Hyprland signature
  local hypr_dir="/run/user/$(id -u)/hypr"
  local hypr_sig=""
  if [[ -d "$hypr_dir" ]]; then
    hypr_sig=$(ls -1 "$hypr_dir" 2>/dev/null | head -1)
  fi

  # Build cron entry with full environment
  local cron_entry="* * * * * DISPLAY=:0 XDG_RUNTIME_DIR=/run/user/$(id -u) HYPRLAND_INSTANCE_SIGNATURE=$hypr_sig $SCRIPT_PATH"

  if ! crontab -l 2>/dev/null | grep -qF "$SCRIPT_PATH"; then
    log "Setting up cron..."
    (crontab -l 2>/dev/null; echo "$cron_entry") | crontab -
  fi
}

main() {
  log "=== Script started ==="

  setup_cron

  if [[ -f "$LOCK_FILE" ]]; then
    local lock_mtime=$(stat -c%Y "$LOCK_FILE" 2>/dev/null) || lock_mtime=0
    local now=$(date +%s)
    local lock_age=$((now - lock_mtime))
    if ((lock_age < LOCK_TIMEOUT)); then
      log "Locked ($lock_age sec < $LOCK_TIMEOUT), skipping"
      exit 0
    fi
  fi

  if check_monitor_power; then
    run_action
  else
    log "Monitor powered on, nothing to do"
  fi
}

main