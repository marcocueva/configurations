#!/bin/bash
WS="$1"
/usr/bin/hyprctl dispatch "hl.dsp.focus({ workspace = \"$WS\" })"

echo "Switching to workspace $1" >>/tmp/waybar_debug.log
