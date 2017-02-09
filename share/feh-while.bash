#!/bin/bash
filetype='*[\(jpg\)\|\(png\)]'
wall="/usr/share/archlinux/wallpaper/$filetype
/usr/share/backgrounds/mate/*/$filetype"
while true; do
  feh --randomize --bg-scale --no-fehbg $wall
  echo -n "feh loop stop it?[stop:<C-c>]:"
  read -t 10 key
  [[ "$key" == "stop" ]] && exit 0
  echo -en "\r"
done
