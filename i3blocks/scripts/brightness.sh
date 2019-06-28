#!/bin/bash
/usr/bin/brightnessctl | /bin/grep Current | /usr/bin/cut -d'(' -f2 | /usr/bin/cut -d')' -f1
