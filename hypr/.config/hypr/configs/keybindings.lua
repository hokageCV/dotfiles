local programs = require("configs.variables")

-- Alt as the main modifier
local mainMod = "ALT"

-- https://wiki.hypr.land/Configuring/Binds/
hl.bind(mainMod .. " + return", hl.dsp.exec_cmd(programs.terminal))
hl.bind(mainMod .. " + Q", hl.dsp.window.kill())
-- hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(programs.file_manager))
hl.bind(mainMod .. " + T", hl.dsp.window.float())
hl.bind(mainMod .. " + space", hl.dsp.exec_cmd(programs.menu))
hl.bind(mainMod .. " + SHIFT + O", hl.dsp.exec_cmd(programs.obsidian))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd(programs.browser))
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.exec_cmd(programs.vscode))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.exec_cmd(programs.kill))
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd(programs.color_picker))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo()) -- dwindle
hl.bind("SUPER + l", hl.dsp.exec_cmd("hyprlock"))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))

-- Switch workspaces with mainMod SHIFT + h/l (prev/next)
hl.bind(mainMod .. " + SHIFT + h", hl.dsp.focus({ workspace = "-1" }))
hl.bind(mainMod .. " + SHIFT + l", hl.dsp.focus({ workspace = "+1" }))

-- Switch workspaces with mainMod + [0-9]
for i = 1, 10 do
    local k = i % 10
    hl.bind(mainMod .. " + " .. k, hl.dsp.focus({ workspace = i }))
end

-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local k = i % 10
    hl.bind(mainMod .. " + SHIFT + " .. k, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("~/dotfiles/scripts/swap-windows-between-workspaces"))

-- Screen recording
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("~/dotfiles/scripts/menu-actions/stop-recording"))

-- restart waybar
hl.bind("CTRL + ALT + R", hl.dsp.exec_cmd("pkill waybar; sleep 0.2; waybar -c ~/.config/waybar/config-edp.json & waybar -c ~/.config/waybar/config-hdmi.json"))

-- wofi menu actions
hl.bind(mainMod .. " + CTRL + S", hl.dsp.exec_cmd("~/dotfiles/scripts/menu-actions.sh"))

-- Example special workspace (scratchpad)
-- hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
-- hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Audacious music player special workspace
hl.bind(mainMod .. " + M", hl.dsp.workspace.toggle_special("audacious"))
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.window.move({ workspace = "special:audacious" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

hl.bind("Print", hl.dsp.exec_cmd("grimshot --notify copy area"))
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd("~/dotfiles/scripts/screenshot-edit.sh"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd(programs.clipboard_manager))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- submap start
hl.bind(mainMod .. " + R", hl.dsp.submap("resize"))
hl.define_submap("resize", function()
    hl.bind("h", hl.dsp.window.resize({ x = -30, y = 0, relative = true }))
    hl.bind("j", hl.dsp.window.resize({ x = 0, y = 30, relative = true }))
    hl.bind("k", hl.dsp.window.resize({ x = 0, y = -30, relative = true }))
    hl.bind("l", hl.dsp.window.resize({ x = 30, y = 0, relative = true }))

    hl.bind("escape", hl.dsp.submap("reset"))
    hl.bind("return", hl.dsp.submap("reset"))
end)
-- submap end

hl.bind(mainMod .. " + CTRL + h", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + CTRL + j", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + CTRL + k", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + CTRL + l", hl.dsp.window.move({ direction = "right" }))

hl.bind("F5", hl.dsp.exec_cmd("voxtype record start"))
hl.bind("F5", hl.dsp.exec_cmd("voxtype record stop"), { release = true })
-- hl.bind(mainMod .. " + SHIFT + s", hl.dsp.exec_cmd(programs.speech_to_text))

hl.bind(mainMod .. " + SHIFT + CTRL + O", hl.dsp.exec_cmd("~/dotfiles/scripts/office-mode.sh"))

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume",         hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"),     { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",         hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),     { locked = true, repeating = true })
hl.bind("XF86AudioMute",                hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),    { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",             hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",          hl.dsp.exec_cmd("brightnessctl s 10%+"),                           { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",        hl.dsp.exec_cmd("brightnessctl s 10%-"),                           { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),        { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"),  { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"),  { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),    { locked = true })