-- Ignore maximize requests from apps
-- hl.window_rule({ match = { class = ".*" }, suppress_event = { "fullscreen", "maximize" } })

-- Audacious music player on special workspace
hl.window_rule({ match = { class = "audacious" }, workspace = "special:audacious" }) -- for Qt mode
hl.window_rule({ match = { class = "Audacious" }, workspace = "special:audacious" }) -- for GTK mode

-- Satty — floating overlay on top of other windows
hl.window_rule({
    name   = "float-satty",
    match  = { class = "^(com%.gabm%.satty)$" },
    float  = true,
    center = true,
})