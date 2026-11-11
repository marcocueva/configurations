#!/usr/bin/env bash

COVER="/tmp/mpd-cover.jpg"

# Extract album art
mpc --format "%file%" current | {
    read -r FILE
    mpc albumart "$FILE" > "$COVER"
}

# Show it in a floating window (Hyprland)
imv --class mpdcover "$COVER" &
