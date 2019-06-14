#!/bin/bash
/usr/bin/scrot -z /tmp/screenshot.png
/usr/bin/notify-send -u low -t 2000 -- 'Now locking...'
/usr/bin/convert /tmp/screenshot.png -blur 0x5 /tmp/screenshotblur.png
/usr/bin/convert /tmp/screenshotblur.png -fill red -gravity South -pointsize 25 -annotate +0+300 'enter password' /tmp/screenshot.png
/usr/bin/i3lock -i /tmp/screenshot.png

