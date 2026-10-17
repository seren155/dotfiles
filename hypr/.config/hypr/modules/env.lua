-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------
local cursor_theme = "Adwaita"
local cursor_size = "28"
-- see https://wiki.hypr.land/configuring/advanced-and-cool/environment-variables/

local function ini_set(file, kv)
	local cmd = string.format(
		"mkdir -p \"$(dirname %s)\"; touch %s; grep -q '^\\[Settings\\]' %s || echo '[Settings]' >> %s",
		file,
		file,
		file,
		file
	)
	for key, val in pairs(kv) do
		cmd = cmd
			.. string.format(
				"; if grep -q '^%s=' %s; then sed -i 's|^%s=.*|%s=%s|' %s; else sed -i '/^\\[Settings\\]/a %s=%s' %s; fi",
				key,
				file,
				key,
				key,
				val,
				file,
				key,
				val,
				file
			)
	end
	hl.exec_cmd(cmd)
end

local function set_cursor_theme(theme, size)
	hl.env("HYPRCURSOR_THEME", theme)
	hl.env("XCURSOR_THEME", theme)
	hl.env("XCURSOR_SIZE", size)
	hl.env("HYPRCURSOR_SIZE", size)

	hl.on("hyprland.start", function()
		hl.exec_cmd("dbus-update-activation-environment --systemd XCURSOR_THEME=" .. theme .. " XCURSOR_SIZE=" .. size)
		hl.exec_cmd("hyprctl setcursor " .. theme .. " " .. size)
		hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme " .. theme)
		hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-size " .. size)

		for _, f in ipairs({ "~/.config/gtk-3.0/settings.ini", "~/.config/gtk-4.0/settings.ini" }) do
			ini_set(f, {
				["gtk-cursor-theme-name"] = theme,
				["gtk-cursor-theme-size"] = size,
			})
		end

		-- GTK2
		hl.exec_cmd(
			"sed -i '/^gtk-cursor-theme/d' ~/.gtkrc-2.0 2>/dev/null; "
				.. "printf 'gtk-cursor-theme-name=\""
				.. theme
				.. '"\\ngtk-cursor-theme-size='
				.. size
				.. "\\n' >> ~/.gtkrc-2.0"
		)

		-- X11 fallback
		hl.exec_cmd(
			"mkdir -p ~/.icons/default && printf '[Icon Theme]\\nInherits="
				.. theme
				.. "\\n' > ~/.icons/default/index.theme"
		)

		-- Flatpak
		hl.exec_cmd(
			"flatpak override --user --env=XCURSOR_THEME="
				.. theme
				.. " --env=XCURSOR_SIZE="
				.. size
				.. " 2>/dev/null || true"
		)

		hl.exec_cmd("xsetroot -cursor_name left_ptr 2>/dev/null || true")
	end)
end

-- Toolkit Backend Variables
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
-- QT Variables
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
-- AMD / Mesa
hl.env("MESA_SHADER_CACHE_MAX_SIZE", "10G")

set_cursor_theme(cursor_theme, cursor_size)
