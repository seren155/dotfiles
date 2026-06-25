-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
	general = {
		gaps_in = 2,
		gaps_out = 7,

		border_size = 2,

		col = {
			active_border = { colors = { "rgb(504945)", "rgb(d79921)" }, angle = 90 },
			inactive_border = "rgba(3c3836aa)",
		},

		-- Set to true to enable resizing windows by clicking and dragging on borders and gaps
		resize_on_border = false,

		-- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
		allow_tearing = false,

		layout = "dwindle",
	},

	decoration = {
		--		rounding = 10,
		--		rounding_power = 2,

		-- Change transparency of focused and unfocused windows
		active_opacity = 1.0,
		inactive_opacity = 0.88,

		shadow = {
			enabled = true,
			range = 60,
			offset = "1 2",
			render_power = 3,
			color = 0x1D2021,
		},

		blur = {
			enabled = true,
			size = 6,
			passes = 1,
			vibrancy = 0.1696,
		},
	},

	animations = {
		enabled = true,
	},
})

-- Spring library
hl.curve("easy", { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 }) -- your original, keep as base
hl.curve("snappy", { type = "spring", mass = 1, stiffness = 120, dampening = 18 }) -- fast UI responses
hl.curve("relaxed", { type = "spring", mass = 1, stiffness = 55, dampening = 14 }) -- workspaces, heavier feel
hl.curve("gentle", { type = "spring", mass = 1, stiffness = 40, dampening = 13 }) -- layers sliding in/out

-- Keep beziers only for opacity/fade (no physical mass to simulate)
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- Animations
hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 4, spring = "snappy" })

hl.animation({ leaf = "windows", enabled = true, speed = 4.79, spring = "snappy" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, spring = "snappy", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, spring = "gentle", style = "popin 87%" })

hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })

hl.animation({ leaf = "layers", enabled = true, speed = 3.81, spring = "gentle" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, spring = "gentle", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, spring = "gentle", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })

hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, spring = "relaxed", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, spring = "relaxed", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, spring = "relaxed", style = "fade" })

hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, spring = "snappy" })

-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
-- hl.window_rule({
--     name  = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding    = 0,
-- })

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
	dwindle = {
		preserve_split = true, -- You probably want this
	},
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
	master = {
		new_status = "master",
	},
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
	scrolling = {
		fullscreen_on_one_column = true,
	},
})
