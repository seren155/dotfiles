-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------
local cursor = "Bibata-Modern-Ice"
local cur_size = "28"
-- see https://wiki.hypr.land/configuring/advanced-and-cool/environment-variables/
hl.env("hyprcursor_theme", cursor)
hl.env("xcursor_theme", cursor)
hl.env("xcursor_size", cur_size)
hl.env("hyprcursor_size", cur_size)

hl.on("hyprland.start", function()
	hl.exec_cmd("hyprctl setcursor " .. cursor .. " " .. cur_size)
	hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme " .. cursor)
	hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-size " .. cur_size)
	-- GTK4
	hl.exec_cmd("mkdir -p ~/.config/gtk-4.0")
	hl.exec_cmd(
		[[printf '%b' '[Settings]\ngtk-cursor-theme-name=]]
			.. cursor
			.. [[\ngtk-cursor-theme-size=]]
			.. cur_size
			.. [[' > ~/.config/gtk-4.0/settings.ini]]
	)
	-- Legacy fallback
	hl.exec_cmd("mkdir -p ~/.icons/default")
	hl.exec_cmd([[printf '%b' '[Icon Theme]\nInherits=]] .. cursor .. [[' > ~/.icons/default/index.theme]])
	-- Qt6
	hl.exec_cmd("mkdir -p ~/.config/qt6ct")
	hl.exec_cmd(
		"grep -q '^cursor_theme=' ~/.config/qt6ct/qt6ct.conf && sed -i 's/^cursor_theme=.*/cursor_theme="
			.. cursor
			.. "/' ~/.config/qt6ct/qt6ct.conf || echo 'cursor_theme="
			.. cursor
			.. "' >> ~/.config/qt6ct/qt6ct.conf"
	)
end)

-- Toolkit Backend Variables
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("CLUTTER_BACKEND", "wayland")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
hl.env("OZONE_PLATFORM", "wayland")
-- XDG Specifications
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
-- QT Variables
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
