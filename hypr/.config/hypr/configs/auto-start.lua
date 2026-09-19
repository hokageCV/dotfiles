-- Autostart apps. hl.exec_cmd is async, so no trailing `&` is needed.
-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Autostart/
hl.on("hyprland.start", function()
    -- hyprpaper at start
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("mako")
    hl.exec_cmd("blueman-applet")
    hl.exec_cmd("systemctl --user start pipewire.service pipewire-pulse.service wireplumber.service xdg-desktop-portal-hyprland.service")
    hl.exec_cmd("/usr/libexec/xdg-desktop-portal") -- start main portal daemon manually (systemd service blocked by missing graphical-session.target on non-KDE sessions)
    hl.exec_cmd("wl-paste --watch cliphist store")
    hl.exec_cmd("hyprctl dispatch workspace 1 && hyprctl dispatch workspace 2")
    hl.exec_cmd("systemctl --user start voxtype")
    hl.exec_cmd("waybar -c ~/.config/waybar/config-edp.json")
    hl.exec_cmd("waybar -c ~/.config/waybar/config-hdmi.json")
end)