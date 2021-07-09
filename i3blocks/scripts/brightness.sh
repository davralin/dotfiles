#!/bin/bash
if [[ "$BLOCK_BUTTON" -eq 1 ]]; then
  /usr/bin/sudo /usr/bin/brightnessctl set 1% > /dev/null
elif [[ "$BLOCK_BUTTON" -eq 2 ]]; then
  /usr/bin/sudo /usr/bin/brightnessctl set 20% > /dev/null
elif [[ "$BLOCK_BUTTON" -eq 3 ]]; then
  /usr/bin/sudo /usr/bin/brightnessctl set 100% > /dev/null
fi
BRIGHTNESS=$(/usr/bin/brightnessctl | /bin/grep Current | /usr/bin/cut -d'(' -f2 | /usr/bin/cut -d')' -f1)

if [ "$(/usr/bin/brightnessctl --list | grep backlight)" ]; then
  echo $BRIGHTNESS
  echo $BRIGHTNESS
fi
