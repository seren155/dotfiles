-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------
local cursor_theme = "MacOS-Tahoe-Cursor"
local cursor_size = "28"
-- see https://wiki.hypr.land/configuring/advanced-and-cool/environment-variables/

local function set_cursor_theme(theme, size)
	hl.env("HYPRCURSOR_THEME", theme)
	hl.env("XCURSOR_THEME", theme)
	hl.env("XCURSOR_SIZE", size)
	hl.env("HYPRCURSOR_SIZE", size)

	hl.on("hyprland.start", function()
		hl.exec_cmd("hyprctl setcursor " .. theme .. " " .. size)
		hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme " .. theme)
		hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-size " .. size)
		-- GTK4
		hl.exec_cmd("mkdir -p ~/.config/gtk-4.0")
		hl.exec_cmd(
			[[printf '%b' '[Settings]\ngtk-cursor-theme-name=]]
				.. theme
				.. [[\ngtk-cursor-theme-size=]]
				.. size
				.. [[' > ~/.config/gtk-4.0/settings.ini]]
		)
		-- Legacy fallback
		hl.exec_cmd("mkdir -p ~/.icons/default")
		hl.exec_cmd([[printf '%b' '[Icon Theme]\nInherits=]] .. theme .. [[' > ~/.icons/default/index.theme]])
		-- Qt6
		hl.exec_cmd("mkdir -p ~/.config/qt6ct")
		hl.exec_cmd(
			"grep -q '^cursor_theme=' ~/.config/qt6ct/qt6ct.conf && sed -i 's/^cursor_theme=.*/cursor_theme="
				.. theme
				.. "/' ~/.config/qt6ct/qt6ct.conf || echo 'cursor_theme="
				.. theme
				.. "' >> ~/.config/qt6ct/qt6ct.conf"
		)
	end)
	-- Qt5
	hl.exec_cmd("mkdir -p ~/.config/qt5ct")
	-- [same grep/sed as qt6 but for qt5ct.conf]

	-- Xresources
	hl.exec_cmd("sed -i '/^Xcursor\\./d' ~/.Xresources 2>/dev/null || true")
	hl.exec_cmd("echo 'Xcursor.theme: " .. theme .. "' >> ~/.Xresources")
	hl.exec_cmd("echo 'Xcursor.size: " .. size .. "' >> ~/.Xresources")

	-- Flatpak
	hl.exec_cmd("flatpak override --user --env=XCURSOR_THEME=" .. theme .. " 2>/dev/null || true")
	hl.exec_cmd("flatpak override --user --env=XCURSOR_SIZE=" .. size .. " 2>/dev/null || true")

	-- Some apps need this
	hl.exec_cmd("xsetroot -cursor_name left_ptr 2>/dev/null || true")
end

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

set_cursor_theme(cursor_theme, cursor_size)
