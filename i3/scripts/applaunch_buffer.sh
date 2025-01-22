#!/bin/sh
if [ -x /usr/bin/flatpak ]; then
 /usr/bin/flatpak run org.gnome.gitlab.cheywood.Buffer
fi
