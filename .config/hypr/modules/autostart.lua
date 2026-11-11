-- modules/autostart.lua
local M = {}

function M.setup(config)
	local terminal = config.terminal
	local browser = config.browser

	hl.on("hyprland.start", function()
		-- Load X11 resource configuration for urxvt and other X11 apps
		hl.exec_cmd("xrdb -merge ~/.Xresources &")

		-- Environment setup for DBus & Systemd (Wayland/Hyprland)
		hl.exec_cmd(
			"dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=Hyprland QT_QPA_PLATFORM XDG_SESSION_TYPE"
		)
		hl.exec_cmd(
			"systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=Hyprland QT_QPA_PLATFORM XDG_SESSION_TYPE"
		)

		-- Restart Portal Service cleanly via systemd instead of launching binaries manually
		hl.exec_cmd("systemctl --user restart xdg-desktop-portal-hyprland xdg-desktop-portal")

		-- Polkit Authentication Agent & Keyring (Background with '&')
		-- Primary: LXQt agent. Fallback: Hyprland polkit / Gnome polkit if present
		hl.exec_cmd("lxqt-policykit-agent &")
		hl.exec_cmd("gnome-keyring-daemon --start --components=secrets &")

		-- Polkit Authentication Agent
		hl.exec_cmd("hyprpolkitagent &")

		-- System Tray and Background Services
		hl.exec_cmd("nm-applet &")
		hl.exec_cmd("blueman-applet &")
		hl.exec_cmd("waybar &")
		hl.exec_cmd("mako &")

		-- Idle, Locking, and Wallpaper
		hl.exec_cmd("hypridle &")
		hl.exec_cmd("~/.config/hypr/scripts/wallpaper.sh &")
		hl.exec_cmd("sunsetr &")

		-- Clipboard Manager
		hl.exec_cmd("wl-paste --type text --watch clipman store --max-items=100 &")
		hl.exec_cmd("clipman restore &")

		-- Workspace-specific autostarts
		hl.exec_cmd('[workspace 1 silent] kitty --title "MainSession"')
		hl.exec_cmd("[workspace 2 silent] " .. browser)
		hl.exec_cmd("[workspace 3 silent] ghostty --class=com.tiled.yazi -e yazi")
		hl.exec_cmd("[workspace 4 silent] thunderbird")

		-- Special Workspaces
		hl.exec_cmd("[workspace special:mail silent] " .. terminal .. " --class floating_mutt -e neomutt")
		hl.exec_cmd(
			"[workspace special:music silent] "
				.. terminal
				.. " --class music_dashboard --session ~/.config/kitty/ncmpcpp.session"
		)
		-- Autostart media notification daemon
		hl.exec_cmd("~/.local/bin/media-notify.sh")
	end)
end

return M
