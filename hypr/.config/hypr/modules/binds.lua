---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal = "kitty"
local fileManager = "kitty yazi"
local fileManager_alt = "thunar"
local menu = "rofi -show drun -show-icons -run-command 'runapp {cmd}'"
-- local menu = "walker"
local browser = "firefox"
local audiocontrol = "pavucontrol"

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier
local h = require("modules.helpers")

-- SUPER - Navigation, layout, core window actions, frequent apps --
h.bind("SUPER + RETURN", terminal)
h.bind("SUPER + B", browser)
h.bind("SUPER + ESCAPE", "wlogout")
h.bind("SUPER + PERIOD", "rofi -modi emoji -show emoji -emoji-format '{emoji}'") ------------------
h.bind("SUPER + SPACE", menu)
h.bind("SUPER + E", fileManager)
-- To switch between windows in a floating workspace:
hl.bind("ALT + TAB", function()
	hl.dispatch(hl.dsp.window.cycle_next()) -- Change focus to another window
	hl.dispatch(hl.dsp.window.bring_to_top()) -- Bring it to the top
end)
hl.bind("PRINT", hl.dsp.exec_cmd("~/.local/bin/scripts/omarchy-capture-screenshot"))
hl.bind(mainMod .. " + T", hl.dsp.layout("togglesplit")) -- dwindle only
local closeWindowBind = hl.bind(mainMod .. " + Q", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())

-- Move focus with mainMod + vim keys
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

-- SUPER + SHIFT - App Launchers, move window to workspace, guarded destructive actions - App Launchers, move window to workspace, guarded destructive actions - App Launchers, move window to workspace, guarded destructive actions - App Launchers, move window to workspace, guarded destructive actions - App Launchers, move window to workspace, guarded destructive actions - App Launchers, move window to workspace, guarded destructive actions - App Launchers, move window to workspace, guarded destructive actions
h.bind("SUPER + SHIFT + E", fileManager_alt)
h.bind("SUPER + SHIFT + T", "~/.local/bin/applications/Telegram/Telegram")
h.bind("SUPER + SHIFT + K", "keepassxc")
h.bind("SUPER + SHIFT + N", terminal .. " -e nvim")
h.bind("SUPER + SHIFT + O", "obsidian")
h.bind("SUPER + SHIFT + S", "steam")

hl.bind(
	mainMod .. " + SHIFT + M",
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
)

-- SUPER + CTRL - System tools, utilities, peripherals --
h.bind("SUPER + CTRL + L", "localsend")
h.bind("SUPER + CTRL + R", "obs")
h.bind("SUPER + CTRL + T", terminal .. " -e btop")
h.bind("SUPER + CTRL + A", audiocontrol)

---- SUPER + ALT - Resize and window manipulation -----
-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
-- hl.bind(mainMod .. " + grave", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e+1" }))

-- Laptop multimedia keys for volume and LCD brightness
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("swayosd-client --output-volume raise"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("swayosd-client --output-volume lower"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"),
	{ locked = true, repeating = true }
)

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
