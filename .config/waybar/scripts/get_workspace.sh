#!/bin/bash

# Get the active workspace ID
active_workspace=$(hyprctl activeworkspace -j | jq -r '.id')

# Get all workspaces
workspaces=$(hyprctl workspaces -j | jq -r '.[] | .id')

# Format the output for Waybar
# The "text" field is the current workspace, and "alt" is the list of all workspaces
echo "{\"text\": \"$active_workspace\", \"alt\": \"$workspaces\", \"tooltip\": \"Switch workspace\"}"
