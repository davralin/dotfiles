#!/bin/sh
if [ -x /opt/firefox/firefox ]; then
  /opt/firefox/firefox
elif [ -x /usr/bin/firefox-esr ]; then
  /usr/bin/firefox-esr
elif [ -x /usr/bin/flatpak ]; then
  /usr/bin/flatpak run --branch=stable --arch=x86_64 --command=firefox --file-forwarding org.mozilla.firefox
fi

