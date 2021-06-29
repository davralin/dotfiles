#!/bin/sh
if [ -x /opt/Element/element-desktop ]; then
  /opt/Element/element-desktop
elif [ -x /usr/bin/flatpak ]; then
 /usr/bin/flatpak run --branch=stable --arch=x86_64 --command=/app/bin/element --file-forwarding im.riot.Riot @@u %U @@
elif [ -x /usr/bin/riot-desktop ]; then
  /usr/bin/riot-desktop
fi

