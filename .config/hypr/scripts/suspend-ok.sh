#!/usr/bin/env bash

# 1. CPU load low?
LOAD=$(awk '{print $1}' /proc/loadavg)
if (( $(echo "$LOAD > 2.0" | bc -l) )); then exit 1; fi

# 2. SSH sessions?
if who | grep -q "pts"; then exit 1; fi

# 3. Downloads running?
if pgrep aria2c >/dev/null; then exit 1; fi
if pgrep wget >/dev/null; then exit 1; fi
if pgrep curl >/dev/null; then exit 1; fi
if pgrep qbittorrent >/dev/null; then exit 1; fi
if pgrep transmission >/dev/null; then exit 1; fi

# All clear
exit 0

