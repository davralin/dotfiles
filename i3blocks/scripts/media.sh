#!/bin/sh
if [[ "$BLOCK_BUTTON" -eq 1 ]]; then
  playerctl next
elif [[ "$BLOCK_BUTTON" -eq 2 ]]; then
  playerctl play-pause
elif [[ "$BLOCK_BUTTON" -eq 3 ]]; then
  playerctl previous
fi
ARTIST=$(playerctl metadata artist)
TITLE=$(playerctl metadata title)
echo "$ARTIST - $TITLE"
