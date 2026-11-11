#!/usr/bin/env bash

COLOR=$(cat ~/.cache/wallcolor 2>/dev/null || echo "#000000")

# Convert hex to rgba with low alpha for dimming
RGBA="${COLOR}55"

# Apply gamma dimming using wlr-randr
OUTPUT=$(hyprctl monitors -j | jq -r '.[0].name')

wlr-randr --output "$OUTPUT" --brightness 0.3

