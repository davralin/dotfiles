#!/bin/bash
# Copyright (C) 2014 Julien Bonjean <julien@bonjean.info>
# Copyright (C) 2014 Alexander Keller <github@nycroth.com>

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

#------------------------------------------------------------------------

# Use the provided interface, otherwise the device used for the default route.
if [[ -n $BLOCK_INSTANCE ]]; then
  IF=$BLOCK_INSTANCE
else
  IF=$(ip route | awk '/^default/ { print $5 ; exit }')
fi

#------------------------------------------------------------------------

# As per #36 -- It is transparent: e.g. if the machine has no battery or wireless
# connection (think desktop), the corresponding block should not be displayed.
#[[ ! -d /sys/class/net/${IF} ]] && exit

#------------------------------------------------------------------------
if [[ "$BLOCK_BUTTON" -eq 1 ]]; then
  PUBLICIP=$(/usr/bin/curl https://icanhazip.com)
  /usr/bin/notify-send -u low "Public IP is: $PUBLICIP"
  /bin/echo $PUBLICIP | /usr/bin/xclip -selection clipboard
  PRIVATEIP="$(/bin/ip a | grep $(/bin/ip route | /usr/bin/awk '/^default/ { print $5 }') | /bin/grep inet | /usr/bin/awk '{ print $2 }' | /usr/bin/awk -F '/' '{ print $1 }')"
  /usr/bin/notify-send -u low "Private IP is: $PRIVATEIP"
fi

if [[ "$(cat /sys/class/net/$IF/operstate)" = 'up' ]]; then
  echo ""
  echo ""
elif [[ "$(cat /sys/class/net/$IF/operstate)" = 'unknown' ]]; then
  echo ""
  echo ""
  echo \#00FF00
else
  echo ""
  echo ""
  echo \#FF0000 # color
fi

#------------------------------------------------------------------------
