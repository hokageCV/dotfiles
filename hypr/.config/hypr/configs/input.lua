-- Input configuration
-- https://wiki.hypr.land/Configuring/Variables/#input
hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 1,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification

        touchpad = {
            natural_scroll = false,
        },
    },
})

-- Mouse sensitivity override for the epic mouse v1
-- https://wiki.hypr.land/Configuring/Variables/#device-specific-options
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})