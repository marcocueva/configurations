#!/usr/bin/env bash

# Export Wayland environment variables (Required for awww on GNOME)
export WAYLAND_DISPLAY="${WAYLAND_DISPLAY:-wayland-0}"
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"
export PATH="$HOME/.local/bin:$PATH"

WALLDIR="$HOME/Wallpapers"
TRANSITION="fade"
DURATION="1"
INTERVAL="1800"

SOCKET_FILE="$XDG_RUNTIME_DIR/wayland-0-awww-daemon.sock"

# Remove stale socket if the process isn't running
if ! pgrep -x "awww-daemon" > /dev/null && ! pgrep -x "swww-daemon" > /dev/null; then
    if [[ -S "$SOCKET_FILE" || -e "$SOCKET_FILE" ]]; then
        rm -f "$SOCKET_FILE"
    fi
    # Launch daemon detached using disown/nohup
    awww-daemon >/dev/null 2>&1 &
    sleep 1
fi

triadic_color() {
    local hex="${1#\#}"

    local r=$(printf "%d" 0x${hex:0:2})
    local g=$(printf "%d" 0x${hex:2:2})
    local b=$(printf "%d" 0x${hex:4:2})

    read h s l <<< $(awk -v r="$r" -v g="$g" -v b="$b" '
        function max(a,b){return a>b?a:b}
        function min(a,b){return a<b?a:b}
        BEGIN {
            r/=255; g/=255; b/=255;
            maxv=max(r,max(g,b));
            minv=min(r,min(g,b));
            l=(maxv+minv)/2;

            if(maxv==minv){
                h=0; s=0;
            } else {
                d=maxv-minv;
                s = l>0.5 ? d/(2-maxv-minv) : d/(maxv+minv);
                if(maxv==r)      h=(g-b)/d + (g<b?6:0);
                else if(maxv==g) h=(b-r)/d + 2;
                else             h=(r-g)/d + 4;
                h*=60;
            }
            print h, s, l;
        }
    ')

    h=$(awk -v h="$h" 'BEGIN { h=(h+120)%360; print h }')

    read r g b <<< $(awk -v r="$r" -v g="$g" -v b="$b" '
        function hue2rgb(p,q,t){
            if(t<0) t+=1;
            if(t>1) t-=1;
            if(t<1/6) return p+(q-p)*6*t;
            if(t<1/2) return q;
            if(t<2/3) return p+(q-p)*(2/3-t)*6;
            return p;
        }
        BEGIN {
            h/=360;
            if(s==0){
                r=g=b=l;
            } else {
                q = l<0.5 ? l*(1+s) : l+s-l*s;
                p = 2*l-q;
                r = hue2rgb(p,q,h+1/3);
                g = hue2rgb(p,q,h);
                b = hue2rgb(p,q,h-1/3);
            }
            printf "%02X %02X %02X", int(r*255), int(g*255), int(b*255);
        }
    ')

    echo "#$r$g$b"
}

set_wallpaper() {
    # 1. Traverse symlinks (-L) and resolve the true path (realpath)
    RAW_WALL=$(find -L "$WALLDIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) 2>/dev/null | shuf -n 1)

    [[ -z "$RAW_WALL" ]] && { echo "Error: No valid wallpapers found in $WALLDIR" >&2; return 1; }

    # Get absolute physical target path
    WALL=$(realpath "$RAW_WALL")

    # 2. Set wallpaper via awww if available
    if command -v awww &>/dev/null; then
        awww img "$WALL" \
            --transition-type "$TRANSITION" \
            --transition-duration "$DURATION" \
            --transition-fps 60
    fi

    # 3. Sync GNOME background setting
    gsettings set org.gnome.desktop.background picture-uri "file://$WALL"
    gsettings set org.gnome.desktop.background picture-uri-dark "file://$WALL"

    # 4. Extract dominant color via ImageMagick
    COLOR=$(magick "$WALL" -resize 1x1 txt:- 2>/dev/null | grep -o "#[A-Fa-f0-9]\{6\}")
    [[ -z "$COLOR" ]] && COLOR="#3584E4"

    TRIAD1=$(triadic_color "$COLOR")
    TRIAD2=$(triadic_color "$TRIAD1")

    # 5. Write colors to GTK4 user CSS
    GTK_CSS_FILE="$HOME/.config/gtk-4.0/gtk.css"
    mkdir -p "$HOME/.config/gtk-4.0"

    cat <<EOF > "$GTK_CSS_FILE"
@define-color accent_color ${COLOR};
@define-color accent_bg_color ${COLOR};
@define-color accent_fg_color #ffffff;
@define-color destructive_color ${TRIAD1};
@define-color destructive_bg_color ${TRIAD1};
@define-color success_color ${TRIAD2};
@define-color success_bg_color ${TRIAD2};
EOF

    echo "$COLOR" > ~/.cache/wallcolor
    echo "$TRIAD1" > ~/.cache/wallcolor_triad1
    echo "$TRIAD2" > ~/.cache/wallcolor_triad2
}

set_wallpaper

while true; do
    sleep "$INTERVAL"
    set_wallpaper
done
