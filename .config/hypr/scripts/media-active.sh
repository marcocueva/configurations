#!/usr/bin/env bash

# 1. mpv playing?
if pgrep mpv >/dev/null; then exit 0; fi

# 2. YouTube fullscreen (Chrome/Firefox)
if xdotool search --onlyvisible --class "chrome\|firefox" | grep -q .; then
    if xdotool getwindowfocus getwindowgeometry | grep -q "Fullscreen"; then
        exit 0
    fi
fi

# 3. Spotify
if pgrep spotify >/dev/null; then exit 0; fi

# 4. mpd playing?
if mpc status | grep -q "

\[playing\]

"; then exit 0; fi

# No media active
exit 1
