#!/usr/bin/env bash

WALLDIR="$HOME/Wallpapers"
TRANSITION="fade"
DURATION="1"
INTERVAL="1800"

# Start awww-daemon if not running
if ! pgrep -x "awww-daemon" > /dev/null; then
    awww-daemon &
    sleep 0.5
fi

set_wallpaper() {
    # Verify wallpaper directory exists
    if [[ ! -d "$WALLDIR" ]]; then
        echo "Error: Directory or symlink '$WALLDIR' does not exist." >&2
        return 1
    fi

    # Find a random image file (following symlinks with -L)
    WALL=$(find -L "$WALLDIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) | shuf -n 1)

    # Check if a valid wallpaper was found
    if [[ -z "$WALL" ]]; then
        echo "Error: No supported images found in '$WALLDIR'." >&2
        return 1
    fi

    # Set wallpaper
    awww img "$WALL" \
        --transition-type "$TRANSITION" \
        --transition-duration "$DURATION" \
        --transition-fps 60
}

# Set one immediately
set_wallpaper

# Loop forever
while true; do
    sleep "$INTERVAL"
    set_wallpaper
done
