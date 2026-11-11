#!/usr/bin/env bash

OUTPUT=$(hyprctl monitors -j | jq -r '.[0].name')
wlr-randr --output "$OUTPUT" --brightness 1.0

# Existing undim commands up here...

# Kill the glitched VRAM instance and start a fresh one
killall hyprpaper
hyprpaper &
