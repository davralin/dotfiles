#!/bin/bash
if [[ "$BLOCK_BUTTON" -eq 1 ]]; then
  playerctl previous
elif [[ "$BLOCK_BUTTON" -eq 2 ]]; then
  playerctl play-pause
elif [[ "$BLOCK_BUTTON" -eq 3 ]]; then
  playerctl next
fi


STATUS=$(playerctl status 2>&1)
if [[ $STATUS == "No players found" ]]; then
  echo ""
elif [[ $STATUS == "Stopped" ]]; then
  echo ""
elif [[ $STATUS == "Paused" ]]; then
  ARTIST=$(playerctl metadata artist)
  TITLE=$(playerctl metadata title)
  echo " $ARTIST - $TITLE"
else
  ARTIST=$(playerctl metadata artist)
  TITLE=$(playerctl metadata title)
  echo "$ARTIST - $TITLE"
fi
