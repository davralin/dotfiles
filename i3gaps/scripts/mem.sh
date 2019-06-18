#!/usr/bin/env bash
if [[ "$BLOCK_BUTTON" -eq 1 ]]; then
  topproc=$(/bin/ps ax --sort=-pmem --format 'command=' | /usr/bin/head -n 1 | /usr/bin/cut -f1 -d' ' | /usr/bin/awk -F" +|/" '{print $NF}')
  msg="<span foreground=\"#FFD000\">$topproc</span>"
else
  memavailable=$(/usr/bin/awk '/MemAvailable/ { printf "%.3f \n", $2/1024/1024 }' /proc/meminfo)
  memtotal=$(/usr/bin/awk '/MemTotal/ { printf "%.3f \n", $2/1024/1024 }' /proc/meminfo)
  output=$(echo "scale=5; 100 - (($memavailable / $memtotal) * 100)" | /usr/bin/bc | /usr/bin/cut -f1 -d'.')

  if [[ "$output" -gt -1 && "$output" -lt 20 ]] ; then
    color="#ADFF00"
    squares="■"
  elif [[ "$output" -gt 20 && "$output" -lt 40 ]] ; then
    color="#E4FF00"
    squares="■■"
  elif [[ "$output" -gt 40 && "$output" -lt 60 ]] ; then
    color="#FFD000"
    squares="■■■"
  elif [[ "$output" -gt 60 && "$output" -lt 80 ]] ; then
    color="#FFB923"
    squares="■■■■"
  elif [[ "$output" -gt 80 && "$output" -lt 101 ]] ; then
    color="#FF0027"
    squares="■■■■■"
  else
    echo "Something wrong"
  fi
  msg="<span foreground=\"$color\">$squares</span>"
fi
echo $msg
