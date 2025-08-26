#!/bin/bash
if [[ "$BLOCK_BUTTON" -eq 1 ]]; then
  mpc prev >/dev/null
elif [[ "$BLOCK_BUTTON" -eq 2 ]]; then
  mpc toggle >/dev/null
elif [[ "$BLOCK_BUTTON" -eq 3 ]]; then
  mpc next >/dev/null
fi

# Get status and track info
STATUS=$(mpc status | awk 'NR==2 {print $1}')
TRACK=$(mpc -f '%artist% - %title%' | head -n1)

if [[ -z "$STATUS" ]]; then
  echo ""
elif [[ "$STATUS" == "[playing]" ]]; then
  echo "$TRACK"
elif [[ "$STATUS" == "[paused]" ]]; then
  echo " $TRACK"
else
  echo ""
fi
