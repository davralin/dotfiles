#!/bin/bash
if [[ "$BLOCK_BUTTON" -eq 1 ]]; then
  /usr/bin/sudo /usr/bin/brightnessctl set 1% > /dev/null
elif [[ "$BLOCK_BUTTON" -eq 3 ]]; then
  /usr/bin/sudo /usr/bin/brightnessctl set 100% > /dev/null
fi
/usr/bin/brightnessctl | /bin/grep Current | /usr/bin/cut -d'(' -f2 | /usr/bin/cut -d')' -f1
