#!/bin/bash

CLASS=$1
COMMAND=$2

# Check if a window with this class is already running
if hyprctl clients | grep -q "class: $CLASS"; then
    # If it exists, focus it
    hyprctl dispatch focuswindow "class:$CLASS"
else
    # If it doesn't exist, run the command
    eval "$COMMAND"
fi
