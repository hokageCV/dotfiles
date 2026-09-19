-- Main Hyprland Lua config.
-- Per-area settings live in configs/*.lua and are loaded below.
require("configs.variables")
require("configs.monitors")
require("configs.auto-start")
require("configs.workspaces")
require("configs.look-and-feel")
require("configs.layouts")
require("configs.input")
require("configs.keybindings")
require("configs.rules")

-- https://wiki.hypr.land/Configuring/Variables/#misc
hl.config({
    misc = {
        force_default_wallpaper = 0,     -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = false, -- If true disables the random hyprland logo / anime girl background. :(
    },
})