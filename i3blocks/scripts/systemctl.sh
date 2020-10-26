#!/bin/bash
STATUS=$(/usr/bin/systemctl is-system-running)

if [ "$(/usr/bin/systemctl is-system-running | grep running)" ]; then
  exit 0
else
  echo $STATUS
  echo $STATUS
  echo \#FF0000 # color
fi

