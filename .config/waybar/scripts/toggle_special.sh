#!/bin/bash

SPECIAL="$1"

# Get current workspace name
CURRENT=$(hyprctl -j monitors | jq -r '.[0].activeWorkspace.name')

# If already on the special workspace → go back to last workspace
if [[ "$CURRENT" == "special:$SPECIAL" ]]; then
  LAST=$(hyprctl -j monitors | jq -r '.[0].lastWorkspace.name')
  hyprctl dispatch "hl.dsp.focus({ workspace = \"$LAST\" })"
  exit 0
fi

# Otherwise → switch to the special workspace
hyprctl dispatch "hl.dsp.focus({ workspace = \"special:$SPECIAL\" })"
