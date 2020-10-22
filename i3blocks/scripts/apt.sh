#!/bin/bash
UPGRADES=$(LANG="" /usr/bin/sudo /usr/bin/apt-get upgrade --simulate | /usr/bin/grep 'newly installed' | /usr/bin/cut -f1 -d' ')

if [ $UPGRADES -gt 0 ]; then
  echo $UPGRADES
  echo $UPGRADES
  echo \#FF0000 # color
fi
