#!/bin/sh

nl='\n'
devices=$(echo devices | bluetoothctl | grep Device | grep -v NEW | cut -d' ' -f3-)
menu="${devices}${nl}Disconnect"
cmd="$(echo "$menu" | rofi -dmenu -p bluetooth)"

case $cmd in
    Disconnect) echo disconnect | bluetoothctl ;;
    *) echo connect $(echo devices | bluetoothctl | grep "$cmd" | grep -v devices | cut -d' ' -f2) | bluetoothctl ;;
esac
