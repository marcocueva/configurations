-- modules/environment.lua
local M = {}

function M.setup()
	-- Environment Variables
	hl.env = {
		{ "GDK_SCALE", "1" },
		{ "GTK_IM_MODULE", "simple" },
		{ "GDK_DPI_SCALE", "1" },
		{ "XCURSOR_SIZE", "24" },
		{ "QT_QPA_PLATFORM", "wayland;xcb" },
		{ "EDITOR", "nvim" },
		{ "MOZ_ENABLE_WAYLAND", "1" },
		{ "MOZ_DISABLE_RDD_SANDBOX", "1" },
		{ "ELECTRON_OZONE_PLATFORM_HINT", "auto" },
		{ "LIBVA_DRIVER_NAME", "nvidia" },
		{ "XDG_SESSION_TYPE", "wayland" },
		{ "GBM_BACKEND", "nvidia-drm" },
		{ "__GLX_VENDOR_LIBRARY_NAME", "nvidia" },
	}

	-- General Configuration
	hl.config({
		general = {
			gaps_in = 6,
			gaps_out = 2,
			border_size = 3,
			col = {
				active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
				inactive_border = "rgba(595959aa)",
			},
			resize_on_border = false,
			layout = "dwindle",
		},
		decoration = {
			rounding = 6,
			active_opacity = 1.0,
			inactive_opacity = 0.9,
		},
	})

	-- Misc Configuration
	hl.misc = {
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
		middle_click_paste = true,
	}
	-- Media keys handling via playerctl
	hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { "l" })
	hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl pause"), { "l" })
	hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { "l" })
	hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { "l" })
	hl.bind("XF86AudioStop", hl.dsp.exec_cmd("playerctl stop"), { "l" })
end

return M
