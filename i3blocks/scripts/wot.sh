#!/bin/bash

script_dir=$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
quotes_file="$script_dir/wot-quotes.tsv"
base_width=1920
base_length=180
min_length=120
max_length=180
max_length_cap=320

if [[ -x /usr/bin/xrandr ]]; then
  display_width=""
  xrandr_output=$(/usr/bin/xrandr --current 2>/dev/null)

  while IFS= read -r line; do
    if [[ $line == *" primary "* && $line =~ ([0-9]+)x[0-9]+\+[0-9]+\+[0-9]+ ]]; then
      display_width=${BASH_REMATCH[1]}
      break
    fi
  done <<< "$xrandr_output"

  if [[ -z $display_width ]]; then
    while IFS= read -r line; do
      if [[ $line == *" connected "* && $line =~ ([0-9]+)x[0-9]+\+[0-9]+\+[0-9]+ ]]; then
        display_width=${BASH_REMATCH[1]}
        break
      fi
    done <<< "$xrandr_output"
  fi

  if [[ $display_width =~ ^[0-9]+$ ]]; then
    max_length=$((display_width * base_length / base_width))

    if (( max_length < min_length )); then
      max_length=$min_length
    elif (( max_length > max_length_cap )); then
      max_length=$max_length_cap
    fi
  fi
fi

if [[ ! -r "$quotes_file" ]]; then
  exit 0
fi

while IFS=$'\t' read -r _ quote author source; do
  with_source="$quote - $author ($source)"
  with_author="$quote - $author"

  if (( ${#with_source} <= max_length )); then
    printf '%s\n' "$with_source"
    exit 0
  fi

  if (( ${#with_author} <= max_length )); then
    printf '%s\n' "$with_author"
    exit 0
  fi

  if (( ${#quote} <= max_length )); then
    printf '%s\n' "$quote"
    exit 0
  fi
done < <(/usr/bin/shuf "$quotes_file")
