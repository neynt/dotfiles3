#!/bin/bash
# Screenshot wrapper

# maim flags:
# -u: hide cursor

if [[ "$1" = "-f" ]]; then
  # Full screenshot to clipboard.
  maim -u | xclip -selection clipboard -t image/png
  notify-send "Screenshot copied to clipboard." --urgency low
elif [[ "$1" = "-c" ]]; then
  # Selection to clipboard.
  maim -u -s | xclip -selection clipboard -t image/png
  notify-send "Screenshot copied to clipboard." --urgency low
else
  # Full screenshot
  screenshots_dir=/loot/screenshots
  date="$(date +%Y-%m-%d)"
  time="$(date +%H:%M:%S)"
  active_window="$(xprop -id $(xdotool getwindowfocus) -notype WM_NAME | cut -d\" -f2 | tr '/' '_')"
  filename="$screenshots_dir/$date/$time - $active_window.png"
  mkdir -p "$(dirname "$filename")"
  maim -u "$filename"
  notify-send "Screenshot saved to $filename" --urgency low
fi
