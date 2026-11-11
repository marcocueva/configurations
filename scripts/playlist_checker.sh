#!/usr/bin/env bash

# CONFIG
MUSIC_DIR="$HOME/Music"
PLAYLIST_DIR="$HOME/.config/mpd/playlists"

echo "Checking if MPD has scanned your library..."

if [ "$(mpc listall | wc -l)" -eq 0 ]; then
    echo "MPD library is empty. Triggering full update..."
    mpc update
    echo "Waiting for MPD to finish scanning..."
    while mpc status | grep -q "Updating DB"; do
        sleep 1
    done
    echo "Library scan complete."
else
    echo "MPD library already scanned."
fi

echo "Fixing and importing .m3u playlists..."

find "$MUSIC_DIR" -type f -name "*.m3u" | while read -r playlist; do
    echo "Processing: $playlist"

    # Create a temporary fixed version
    tmp="$(mktemp)"

    # Convert absolute paths → relative paths
    sed "s|$MUSIC_DIR/||g" "$playlist" > "$tmp"

    # Move into MPD playlist directory
    base=$(basename "$playlist")
    mv "$tmp" "$PLAYLIST_DIR/$base"

    echo "Imported: $base"
done

echo "Refreshing MPD playlist database..."
mpc update

echo "Done. Your playlists should now show full metadata in ncmpcpp."

