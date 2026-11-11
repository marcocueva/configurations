-- modules/bindings.lua
local M = {}

function M.setup(config)
  local mainMod = config.mainMod
  local terminal = config.terminal
  local browser = config.browser
  local fileManager = config.fileManager

  -- Launchers
  hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
  hl.bind(mainMod .. " + ALT + M",
    hl.dsp.exec_cmd("[workspace special:mail silent] " .. terminal .. " --class floating_mutt -e neomutt"))
  hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd("alacritty"))
  hl.bind(mainMod .. " + SHIFT + U", hl.dsp.exec_cmd("urxvt"))
  hl.bind(mainMod .. " + ALT + F", hl.dsp.exec_cmd("foot"))
  hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd("tilix"))
  -- hl.bind(mainMod .. " + G", hl.dsp.exec_cmd("env GTK_IM_MODULE = simple ghostty"))
  hl.bind(mainMod .. " + G", hl.dsp.exec_cmd("env GTK_IM_MODULE=simple ghostty"))
  hl.bind(mainMod .. " + Y", hl.dsp.exec_cmd("kitty --class=com.tiled.yazi -e yazi"))
  hl.bind(mainMod .. " + F2", hl.dsp.exec_cmd(browser))
  hl.bind(mainMod .. " + F3", hl.dsp.exec_cmd(fileManager))
  hl.bind(mainMod .. " + F9", hl.dsp.exec_cmd("strawberry"))
  hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("wofi --show drun -i"))
  hl.bind(mainMod .. " + ALT + D", hl.dsp.exec_cmd("hyprlauncher"))
  hl.bind(mainMod .. " + SHIFT + F", hl.dsp.exec_cmd("firefox"))
  hl.bind(mainMod .. " + SHIFT + N",
    hl.dsp.exec_cmd("[workspace special:music silent] " ..
      terminal .. " --class music_dashboard --session ~/.config/kitty/ncmpcpp.session"))
  hl.bind(mainMod .. " + CTRL + H", hl.dsp.exec_cmd("alacritty --class htop -e htop"))
  hl.bind(mainMod .. " + CTRL + V", hl.dsp.exec_cmd("alacritty --class vim -e vim"))
  hl.bind(mainMod .. " + T",
    hl.dsp.exec_cmd("swww img \"$(find ~/Candy/Wallpapers -type f | shuf -n 1)\" --transition-type center"))

  -- screenshots with grim For example, to select an area and open it in swappy:
  hl.bind("Print", hl.dsp.exec_cmd('grim -g "$(slurp)" - | swappy -f -'))

  -- To copy a selected area directly to the clipboard, install wl-clipboard and use:
  hl.bind("SUPER + Print", hl.dsp.exec_cmd('grim -g "$(slurp -d)" - | wl-copy'))

  -- Window control
  hl.bind("ALT + Q", hl.dsp.window.close())
  hl.bind("CTRL + Q", hl.dsp.window.kill())
  hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))
  hl.bind(mainMod .. " + SHIFT + Space", hl.dsp.window.float({ action = "toggle" }))

  -- Focus & Move
  hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
  hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
  hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
  hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

  -- Move focus with mainMod + arrow keys
  hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
  hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
  hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
  hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

  -- Move Windows
  --   hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.drag("left"))
  --   hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.drag("right"))
  --   hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.drag("up"))
  --   hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.drag("down"))
  -- Example using moveactive for keyboard window movement:
--  hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move_active({ x = -20, y = 0 }))
--  hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move_active({ x = 20, y = 0 }))
--  hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move_active({ x = 0, y = -20 }))
--  hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move_active({ x = 0, y = 20 }))

  -- Swap Windows
  hl.bind(mainMod .. " + CTRL + L", hl.dsp.window.swap({ direction = "l" }))
  hl.bind(mainMod .. " + CTRL + R", hl.dsp.window.swap({ direction = "r" }))

  -- Move/resize windows with mainMod + LMB/RMB and dragging
  hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
  hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

  -- Incremental move for floating windows
  hl.bind(mainMod .. " + ALT + L", hl.dsp.window.move({ x = 20, y = 0, relative = true }))
  hl.bind(mainMod .. " + ALT + H", hl.dsp.window.move({ x = -20, y = 0, relative = true }))
  hl.bind(mainMod .. " + ALT + K", hl.dsp.window.move({ x = 0, y = -20, relative = true }))
  hl.bind(mainMod .. " + ALT + J", hl.dsp.window.move({ x = 0, y = 20, relative = true }))


  -- Workspaces
  for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
  end

  -- Scroll through existing workspaces with mainMod + scroll
  hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
  hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

  -- Scratchpad
  hl.bind(mainMod .. " + SHIFT + minus", hl.dsp.window.move({ workspace = "special:magic" }))
  hl.bind(mainMod .. " + minus", hl.dsp.workspace.toggle_special())
  hl.bind(mainMod .. " + M", hl.dsp.workspace.toggle_special("mail"))
  hl.bind(mainMod .. " + N", hl.dsp.workspace.toggle_special("music"))

  -- Scroll through existing workspaces with mainMod + scroll
  hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
  hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

  -- Hardware & Multimedia
  hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
  hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })
  hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
    { locked = true, repeating = true })
  hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    { locked = true, repeating = true })
  hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { locked = true, repeating = true })
  hl.bind(mainMod .. " +code:82", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    { locked = true, repeating = true })
  hl.bind(mainMod .. " +code:86", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"),
    { locked = true, repeating = true })
  hl.bind(mainMod .. " +code:91", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { locked = true, repeating = true })

  -- Playerctl
  hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
  hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
  hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
  hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

  -- Remote Speakers
  hl.bind(mainMod .. " + ALT + S", hl.dsp.exec_cmd(
    "pactl load-module module-combine-sink sink_name=combined sink_properties=device.description=Whole-House slaves=" ..
    config.laptopSink .. "," .. config.sonos1 .. "," .. config.sonos2 .. "," .. config.sonos3 ..
    "; sleep 0.5; pactl move-sink-input $(pactl list short sink-inputs | cut -f1) combined; notify-send -t 2000 \"Audio\" \"Whole House Enabled\""
  ))
  hl.bind(mainMod .. " + ALT + L", hl.dsp.exec_cmd(
    "pactl move-sink-input $(pactl list short sink-inputs | cut -f1) " .. config.laptopSink ..
    " && pactl unload-module module-combine-sink && notify-send -t 2000 \"Audio\" \"D-Top Only\" -i audio-card"
  ))
  hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exec_cmd("loginctl terminate-user \"\""))

  -- Reload Hyprland
  hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd(
    "hyprctl reload && notify-send \"Hyprland\" \"Config Reloaded\""))
  hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("pkill waybar; waybar &"))

  -- Submaps
  hl.bind(mainMod .. " + R", hl.dsp.submap("resize"))
  hl.bind("SUPER + escape", hl.dsp.submap("logout"))
  hl.bind("CONTROL + ALT + L", hl.dsp.exec_cmd("hyprlock"))
end

return M
