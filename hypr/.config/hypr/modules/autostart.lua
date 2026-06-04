-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
-- hl.on("hyprland.start", function ()
--   hl.exec_cmd(terminal)
--   hl.exec_cmd("nm-applet")
--   hl.exec_cmd("waybar & hyprpaper & firefox")
-- end)

hl.on("hyprland.start", function()
	hl.exec_cmd("systemctl --user enable --now waybar.service")
	hl.exec_cmd("waypaper --restore")
	hl.exec_cmd("systemctl --user start hyprpolkitagent")
	hl.exec_cmd("hypridle")
	hl.exec_cmd("/usr/lib/pam_kwallet_init")
	hl.exec_cmd("runapp keepassxc")
	hl.exec_cmd("hyprctl setcursor Adwaita 24")
	hl.exec_cmd("swayosd-server")
end)
