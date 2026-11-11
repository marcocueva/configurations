-- modules/windowrules.lua
local M = {}

function M.setup()
  -- Suppress maximize events
  hl.window_rule({
    name = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize"
  })

  -- Workspace assignments for regular apps
  hl.window_rule({
    workspace = 2,
    match = { class = "^(google-chrome|chrome|Google-chrome)$" }
  })

  hl.window_rule({
    workspace = 3,
    match = { class = "^(brave-browser|Brave-browser)$" }
  })

  hl.window_rule({
    workspace = 3,
    match = { class = "^(nemo|org.kde.dolphin|Thunar)$" }
  })

  hl.window_rule({
    workspace = 4,
    match = { class = "^(thunderbird|Thunderbird)$" }
  })

  hl.window_rule({
    workspace = 5,
    match = { class = "^(libreoffice.*)$" }
  })

  hl.window_rule({
    workspace = 5,
    match = { class = "^(org.mozilla.firefox|Firefox)$" }
  })

  hl.window_rule({
    workspace = 6,
    match = { class = "^(org.kde.digikam|org.gnome.Shotwell|darktable)$" }
  })

  hl.window_rule({
    workspace = 7,
    match = { class = "^(krita|gimp|Gimp)$" }
  })

  hl.window_rule({
    workspace = 8,
    match = { class = "^(blender|Blender)$" }
  })

  hl.window_rule({
    workspace = 8,
    match = { class = "^(Bforartists|bforartists)$" }
  })

  hl.window_rule({
    workspace = 8,
    match = { class = "^(OrcaSlicer|orcaslicer)$" }
  })

  hl.window_rule({
    workspace = 9,
    match = { class = "^(Shotcut|org.kde.kdenlive|Openshot|openshot)$" }
  })

  hl.window_rule({
    workspace = 10,
    match = { class = "^(librecad|org.inkscape.Inkscape|FreeCAD|freecad)$" }
  })

  hl.window_rule({
    workspace = 10,
    match = { class = "^(IngeTrazo)$" }
  })
  -- Special workspaces
  hl.window_rule({
    workspace = "special:mail",
    match = { class = "^(floating_mutt)$" }
  })

  hl.window_rule({
    workspace = "special:music",
    match = { class = "^(music_dashboard)$" }
  })

  hl.window_rule({
    match = { class = "^org%.pwmt%.zathura$" },
    float = true,
    move = { "0", "0" },
    size = { "30%", "100%" },
  })
  -- Floating rules
  hl.window_rule({
    match = { float = true },
    fullscreen_state = 0,
    maximize = false,
    size = { 720, 640 },
    fullscreen = false
  })

  hl.window_rule({
    match = { class = "^(mpv|vlc|Vlc|org.gnome.Decibels)$" },
    float = true,
    size = { 1600, 900 },
    center = true
  })

  hl.window_rule({
    match = { class = "^(gvim|Gvim|emacs)$" },
    float = true,
    size = { 1600, 900 }
  })

  hl.window_rule({
    match = { class = "^(htop|Htop)$" },
    float = true,
    size = { "50%", "40%" },
    move = { 0, 40 }
  })

  hl.window_rule({
    match = { class = "^(ncmpcpp|Ncmpcpp)$" },
    float = true,
    size = { "40%", "40%" }
  })

  hl.window_rule({
    match = { class = "^(org.gnome.Totem|Totem)$" },
    float = true,
    size = { "40%", "40%" }
  })

  hl.window_rule({
    match = { class = "^(audacious|Audacious)$" },
    float = true,
    size = { 800, 640 }
  })

  hl.window_rule({
    match = { class = "^(peazip|Peazip)$" },
    float = true,
    size = { 800, 640 }
  })

  hl.window_rule({
    match = { class = "^(org.qbittorrent.qBittorrent|qBittorrent)$" },
    float = true,
    size = { 900, 720 }
  })

  hl.window_rule({
    match = { class = "^(nmtui|Nmtui)$" },
    float = true
  })

  hl.window_rule({
    match = { title = ".*nvim.*" },
    float = true,
    size = { 1000, 600 },
    center = true
  })

  hl.window_rule({
    match = { class = "^(org.gnome.Evince|Evince)$" },
    float = true,
    size = { 1200, 1400 }
  })

  hl.window_rule({
    match = { class = "^(org.strawberrymusicplayer.strawberry|Strawberry)$" },
    float = true,
    size = { "50%", "40%" },
    center = true
  })

  hl.window_rule({
    match = { class = "^(org.gnome.Software|Software)$" },
    float = true
  })

  hl.window_rule({
    match = { class = "^(lxqt-policykit-agent|Policykit)$" },
    float = true
  })

  hl.window_rule({
    match = { class = "^(org.pulseaudio.pavucontrol|Pavucontrol)$" },
    float = true,
    size = { "30%", "24%" }
  })

  hl.window_rule({
    match = { class = "^(pavucontrol|blueman-manager|Blueman-manager)$" },
    float = true,
    size = { "30%", "24%" }
  })

  hl.window_rule({
    match = { class = "^(gnome-calculator|Calculator)$" },
    float = true
  })

  hl.window_rule({
    match = { class = "^(xdg-desktop-portal-gtk|Xdg-desktop-portal-gtk)$" },
    float = true,
    size = { 1080, 900 },
    center = true
  })

  hl.window_rule({
    match = { class = "^(spnavcfg|Spnavcfg)$" },
    float = true
  })

  -- Dialog Windows
  hl.window_rule({
    workspace = "current",
    match = { title = "^(Save File|Open File|Confirm|Preferences|.*Properties|Settings|Library|Remove torrent'(s)')$" },
    float = true,
    size = { 900, 720 }
  })

  hl.window_rule({
    match = { initial_title = "^(File Browser)" },
    workspace = "current",
    float = true,
    size = { 900, 720 }
  })

  hl.window_rule({
    match = { class = "^(Save File|Open File|Confirm|Preferences|.*Properties|Settings|Library)$" },
    workspace = "current",
    float = true,
    size = { 900, 720 }

  })

  hl.window_rule({
    match = { title = "^(New Album — digiKam)$" },
    float = true,
    center = true
  })

  hl.window_rule({
    name = "chrome-open-file",
    match = { class = "^(google-chrome)$", title = "^(Open File)$" },
    float = true,
    size = { 900, 720 }

  })

  hl.window_rule({
    match = { title = "^(File Operation Progress)$" },
    float = true
  })

  hl.window_rule({
    name = "ff-pip-float",
    match = { class = "^(firefox)$", title = "^(Picture-in-Picture)$" },
    float = true,
  })

  hl.window_rule({ name = "ff-pip-pin", match = { class = "^(firefox)$", title = "^(Picture-in-Picture)$" }, pin = true })

  hl.window_rule({
    name = "ff-sharing-indicator",
    match = { class = "^(firefox)$", title = "^(Firefox — Sharing Indicator)$" },
    float = true,
  })

  hl.window_rule({
    match = { class = "^(mpdcover|Mpdcover)$" },
    float = true,
    size = { 240, 240 },
    move = { 20, 20 }
  })

  -- Terminals
  hl.window_rule({
    match = { class = "^(Alacritty|alacritty|tilix|Tilix|kitty|Kitty|foot)$" },
    float = true,
    size = { 1080, 720 }
  })

  hl.window_rule({
    match = { class = "^(com.mitchellh.ghostty|Ghostty)$" },
    float = true,
    size = { 1080, 720 }
  })

  hl.window_rule({
    match = { class = "^(com.tiled.yazi|Yazi)$" },
    float = false
  })

  hl.window_rule({
    match = { class = "^(floating_mutt|Floating_mutt)$" },
    float = true,
    size = { 1400, 800 },
    move = { "2%", 20 }
  })

  hl.window_rule({
    match = { class = "^(music_dashboard|Music_dashboard)$" },
    float = true,
    size = { 1400, 800 },
    move = { "52%", 20 }
  })

  hl.window_rule({
    match = { title = "^(MainSession)$" },
    tile = true
  })

  hl.window_rule({
    match = { class = "^(lxqt-policykit-agent|Lxqt-policykit-agent)$" },
    stay_focused = true
  })
end

return M
