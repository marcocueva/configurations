-- modules/submaps.lua
local M = {}

function M.setup()
  -- Resize Submap
  hl.define_submap("resize", function()
    hl.bind("L", hl.dsp.window.resize({ x = 40, y = 0, relative = true }), { repeating = true })
    hl.bind("Right", hl.dsp.window.resize({ x = 40, y = 0, relative = true }), { repeating = true })
    hl.bind("H", hl.dsp.window.resize({ x = -40, y = 0, relative = true }), { repeating = true })
    hl.bind("Left", hl.dsp.window.resize({ x = -40, y = 0, relative = true }), { repeating = true })
    hl.bind("K", hl.dsp.window.resize({ x = 0, y = -40, relative = true }), { repeating = true })
    hl.bind("Up", hl.dsp.window.resize({ x = 0, y = -40, relative = true }), { repeating = true })
    hl.bind("J", hl.dsp.window.resize({ x = 0, y = 40, relative = true }), { repeating = true })
    hl.bind("Down", hl.dsp.window.resize({ x = 0, y = 40, relative = true }), { repeating = true })
    hl.bind("escape", hl.dsp.submap("reset"))
    hl.bind("Return", hl.dsp.submap("reset"))
  end)

  -- Logout Submap
  hl.on("keybinds.submap", function(name)
    if name == "logout" then
      hl.notification.create({
        text = "c - reload\ne - exit\nr - reboot\ns - suspend\nS - poweroff\nl - lock",
        duration = 4500,
        color = "rgb(34E2E2)",
        font_size = 16,
      })
    end
  end)

  hl.define_submap("logout", function()
    hl.bind("C", function()
      hl.dispatch(hl.dsp.submap("reset"))
      hl.dispatch(hl.dsp.exec_cmd("hyprctl dismissnotify"))
      hl.dispatch(hl.dsp.exec_cmd("hyprctl reload"))
    end)
    hl.bind("E", function()
      hl.dispatch(hl.dsp.submap("reset"))
      hl.dispatch(hl.dsp.exec_cmd("hyprctl dismissnotify"))
      hl.dispatch(hl.dsp.exit())
    end)
    hl.bind("S", function()
      hl.dispatch(hl.dsp.submap("reset"))
      hl.dispatch(hl.dsp.exec_cmd("hyprctl dismissnotify"))
      hl.dispatch(hl.dsp.exec_cmd("systemctl suspend"))
    end)
    hl.bind("R", function()
      hl.dispatch(hl.dsp.submap("reset"))
      hl.dispatch(hl.dsp.exec_cmd("hyprctl dismissnotify"))
      hl.dispatch(hl.dsp.exec_cmd("systemctl reboot"))
    end)
    hl.bind("SHIFT + S", function()
      hl.dispatch(hl.dsp.submap("reset"))
      hl.dispatch(hl.dsp.exec_cmd("hyprctl dismissnotify"))
      hl.dispatch(hl.dsp.exec_cmd("systemctl poweroff -i"))
    end)
    hl.bind("L", function()
      hl.dispatch(hl.dsp.exec_cmd("hyprctl dismissnotify"))
      hl.dispatch(hl.dsp.exec_cmd("hyprlock"))
      hl.dispatch(hl.dsp.submap("reset"))
    end)
    hl.bind("escape", function()
      hl.dispatch(hl.dsp.exec_cmd("hyprctl dismissnotify"))
      hl.dispatch(hl.dsp.submap("reset"))
    end)
    hl.bind("Return", function()
      hl.dispatch(hl.dsp.exec_cmd("hyprctl dismissnotify"))
      hl.dispatch(hl.dsp.submap("reset"))
    end)
  end)
end

return M
