#!/bin/bash
rm /tmp/screenshot.png
scrot -z /tmp/screenshot.png
notify-send -u low -t 2000 -- 'Now locking...'
convert /tmp/screenshot.png -blur 0x5 /tmp/screenshotblur.png
convert /tmp/screenshotblur.png -fill red -gravity South -pointsize 25 -annotate +0+300 'enter password' /tmp/screenshot.png
rm /tmp/screenshotblur.png
rm /tmp/screenshot_*.png
i3lock -i /tmp/screenshot.png

