#!/bin/bash

# 1. Get Root Disk space for the bar
MAIN_DISK=$(df -h / | awk 'NR==2 {print $4}')

# 2. Get all physical disks for the tooltip, ignoring temp/loop files
# We format it into a neat table
TOOLTIP_DATA=$(df -h -x tmpfs -x devtmpfs -x squashfs | awk 'NR>1 {printf "%-15s %-6s %-5s\n", $6, $4, $5}')

# 3. Use JQ to build the JSON. 
# This handles the quotes and newlines perfectly.

# Change the last line to this:
jq -c -n \
  --arg text "󰋊 $MAIN_DISK" \
  --arg tooltip "Mounted        Avail  Use%
$TOOLTIP_DATA" \
  '{"text": $text, "tooltip": $tooltip}'
