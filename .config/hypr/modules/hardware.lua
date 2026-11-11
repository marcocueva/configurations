-- modules/hardware.lua
local M = {}

function M.setup()
  -- Monitors
  hl.monitors = {
    {
      name = "DP-2",
      resolution = "2560x1440@59.95",
      position = "0x0",
      scale = 1
    }
  }
  -- Force Hyprland to ignore broken EDID physical sizes for XWayland/Fontconfig
  hl.exec_cmd("hyprctl keyword monitor DP-2,2560x1440@59.95,0x0,1")

  -- Input Configuration
  hl.config({
    input = {
      kb_layout = "se",
      -- kb_variant = "nodeadkeys",
      kb_options = "caps:escape_shifted_capslock",
      follow_mouse = 1,
      sensitivity = 0,
      natural_scroll = false,
      scroll_factor = 0.5,
      touchpad = {
        natural_scroll = false
      }
    },
    cursor = {
      no_hardware_cursors = true
    }
  })

  -- Device Configuration
  hl.device = {
    {
      name = "all",
      natural_scroll = false,
      scroll_factor = 0.5
    }
  }
end

return M
