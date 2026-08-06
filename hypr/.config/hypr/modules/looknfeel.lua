-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 10,

		border_size = 2,

		-- Set to true to enable resizing windows by clicking and dragging on borders and gaps
		resize_on_border = false,

		-- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
		allow_tearing = false,

		layout = "dwindle",
	},

	decoration = {
		rounding = 20,
		rounding_power = 2,

		-- Change transparency of focused and unfocused windows
		active_opacity = 1.0,
		inactive_opacity = 0.90,

		shadow = {
			enabled = true,
			range = 4,
			--			offset = "1 2",
			render_power = 3,
			color = 0xee1a1a1a,
		},

		blur = {
			enabled = true,
			size = 3,
			passes = 2,
			vibrancy = 0.1696,
		},
	},

	animations = {
		enabled = true,
	},
})

hl.curve("snappy", { type = "spring", mass = 1, stiffness = 280, dampening = 28 }) -- Fast with slight bounce
hl.curve("snappier", { type = "spring", mass = 1, stiffness = 400, dampening = 32 }) -- Very fast, minimal bounce
hl.curve("quick", { type = "spring", mass = 1, stiffness = 180, dampening = 22 }) -- For subtle movements
hl.curve("smooth", { type = "spring", mass = 1, stiffness = 120, dampening = 18 }) -- For workspace transitions

-- Bezier curves for smooth slides
hl.curve("slideIn", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } }) -- Fast slide in
hl.curve("slideOut", { type = "bezier", points = { { 0.5, 0 }, { 0.5, 1 } } }) -- Smooth slide out
hl.curve("slideFast", { type = "bezier", points = { { 0.25, 0 }, { 0.1, 1 } } }) -- Quick slide
hl.curve("fadeCurve", { type = "bezier", points = { { 0.35, 0 }, { 0.1, 1 } } }) -- Fast fade

-- ANIMATIONS
hl.animation({ leaf = "global", enabled = true, speed = 12, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 6, spring = "snappy" })

hl.animation({ leaf = "windows", enabled = true, speed = 4, spring = "snappier" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 3.5, spring = "snappier", style = "popin" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 2.5, spring = "snappier", style = "slide" })

hl.animation({ leaf = "layers", enabled = true, speed = 3.5, spring = "snappy" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 3, spring = "snappy", style = "slide" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 2.5, spring = "snappy", style = "slide" })

-- Workspaces - fade only, no movement
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "fadeCurve", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 4, bezier = "fadeCurve", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 3.5, bezier = "fadeCurve", style = "fade" })

hl.animation({ leaf = "zoomFactor", enabled = true, speed = 8, spring = "snappier" })

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
