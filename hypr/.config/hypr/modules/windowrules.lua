--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
	-- Ignore maximize requests from all apps. You'll probably like this.
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
	-- Fix some dragging issues with XWayland
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

hl.window_rule({
	name = "KeePassXC",
	match = {
		class = "^(KeePassXC)$",
	},
	workspace = "name:🗝 silent",
})
-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },

	move = "20 monitor_h-120",
	float = true,
})

-- don't trigger hypridle for fullscreen programs
hl.window_rule({
	match = {
		class = "^(.*)$",
	},
	idle_inhibit = "fullscreen",
	immediate = true,
	no_shadow = true,
	no_blur = true,
	no_anim = true,
	rounding = 0,
})

-- Float and center dialogs/pickers
hl.window_rule({
	name = "float-dialogs",
	match = { title = "^(Open File|Save As|Select a File|Open Folder|File Upload)(.*)$" },
	float = true,
	center = true,
})

-- Steam
hl.window_rule({
	name = "steam-dialogs",
	match = { class = "^(steam)$", title = "^(Steam Settings|Friends List|.* - Chat)$" },
	float = true,
})

hl.window_rule({
	name = "picture-in-picture",
	match = { title = "^([Pp]icture[%-%s]?[Ii]n[%-%s]?[Pp]icture)(.*)$" },
	float = true,
	pin = true,
	-- Adjust these coordinates to your preference
	move = "75% 75%",
	size = "25% 25%",
	keep_aspect_ratio = true,
})

-- Audio controls
hl.window_rule({
	name = "small-utility-apps",
	match = {
		class = "^(com-abdownloadmanager-desktop-AppKt|org.pulseaudio.pavucontrol|blueman-manager|nm-connection-editor)$",
	},
	float = true,
	center = true,
	size = "800 600",
})

hl.layer_rule({
	name = "noctalia",
	match = {
		namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd|window-switcher)$",
	},
	no_anim = true,
	ignore_alpha = 0.5,
	blur = true,
	blur_popups = true,
})

hl.window_rule({
	name = "browser-workspace",
	match = {
		class = "^(firefox)$",
	},
	workspace = "name:Web",
})

hl.window_rule({
	name = "steam-workspace",
	match = {
		class = "^([Ss]team)$",
	},
	workspace = "name:Games",
})
