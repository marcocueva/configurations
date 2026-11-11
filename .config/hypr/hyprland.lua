-- === Hyprland Lua Config (v0.55) ===
-- Uses hl.dsp for commands and window actions
-- === Variables ===
local mainMod = "SUPER"
local fileManager = "nautilus"
local terminal = "kitty"
local browser = "google-chrome-stable"
local laptopSink = "alsa_output.pci-0000_00_1f.3.analog-stereo"
local sonos1 = "raop_sink.Sonos-542A1BBE4948.local.192.168.68.102.7000"
local sonos2 = "raop_sink.Sonos-38420B2EA24C.local.192.168.68.106.7000"
local sonos3 = "raop_sink.Sonos-542A1BBE4066.local.192.168.68.105.7000"

-- Load the bindings module
local bindings = require("modules.bindings")
bindings.setup({
  mainMod = mainMod,
  terminal = terminal,
  browser = browser,
  fileManager = fileManager,
  laptopSink = laptopSink,
  sonos1 = sonos1,
  sonos2 = sonos2,
  sonos3 = sonos3
})
-- Load the submaps module
local submaps = require("modules.submaps")
submaps.setup()

-- === Load Modules ===
local environment = require("modules.environment")
local hardware = require("modules.hardware")
local autostart = require("modules.autostart")
local windowrules = require("modules.windowrules")

-- Setup Modules
environment.setup()
hardware.setup()
autostart.setup({
  terminal = terminal,
  browser = browser
})
windowrules.setup()
