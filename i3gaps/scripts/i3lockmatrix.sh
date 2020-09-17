#!/bin/bash
xfce4-terminal --hide-toolbar --hide-menubar --hide-scrollbar -e cmatrix &
sleep 0.2
i3-msg fullscreen
i3lock -n ; i3-msg kill
