-- Programs used by keybindings. Import via:
--   local programs = require("configs.variables")
local programs = {
    terminal         = "kitty",
    file_manager     = "dolphin",
    menu             = "wofi --show drun",
    clipboard_manager = "cliphist list | wofi --dmenu --matching fuzzy --insensitive | cliphist decode | wl-copy",
    obsidian         = "flatpak run md.obsidian.Obsidian",
    browser          = "brave-browser",
    vscode           = "code",
    kill             = "hyprctl kill",               -- kill a specific window, with mouse
    speech_to_text   = "~/dotfiles/scripts/sst.sh",
    color_picker     = "hyprpicker -a -f hex",
}

-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("GTK_THEME", "Adwaita:dark")
hl.env("GTK_COLOR_SCHEME", "prefer-dark")

hl.env("XDG_SESSION_TYPE", "wayland")        -- required for xdg-desktop-portal-hyprland screencopy
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")    -- portal backend selection
hl.env("XDG_SESSION_DESKTOP", "Hyprland")    -- portal backend selection

return programs