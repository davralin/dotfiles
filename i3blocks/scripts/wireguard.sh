#!/bin/bash
for i in $(sudo find /etc/wireguard/ -iname '*.conf' | sed 's:/etc/wireguard/::g' | sed 's/.conf//g')
do
  sudo wg show $i >/dev/null 2>&1
  if [ $? -eq 0 ]
  then
    echo ""
    echo ""
    echo \#00FF00 # color
  else
    echo "$i"
    echo "$i"
    echo \#FF0000 # color
  fi
done
