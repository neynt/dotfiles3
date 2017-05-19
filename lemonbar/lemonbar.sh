#!/bin/bash
set -f

# config
panel_fifo="/tmp/panel-fifo"
color_foreground="#aaaaaa"
color_background="#000000"

[ -e "$panel_fifo" ] && rm "$panel_fifo"
mkfifo "$panel_fifo"

# Workspaces
bspc subscribe > "$panel_fifo" &

# Clock
while true; do
  echo "C$(date "+%a %b %d, %H:%M")"
  sleep 1
done > "$panel_fifo" &

cat "$panel_fifo" | python3 lemonbar.py | lemonbar -u 2 -d -p -F $color_foreground -B $color_background
