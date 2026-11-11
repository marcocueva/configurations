#!/usr/bin/env bash

FILE=$(mpc --format "%file%" current)
mpc albumart "$FILE" | base64 -w 0
