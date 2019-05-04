#!/bin/bash
# Screenshot wrapper
# Uses maim (which uses slop)
# "Friendship ended with scrot. Now maim is my best friend."
# Based off screenshot script found in elenapan/dotfiles

SCREENSHOTS_DIR=~/Dropbox/Screenshots
TIMESTAMP="$(date +%Y-%m-%d.%H:%M:%S)"
FILENAME=$SCREENSHOTS_DIR/$TIMESTAMP.screenshot.png

# maim flags:
# -u option hides cursor

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
  maim -u $FILENAME
  notify-send "Screenshot saved to $FILENAME" --urgency low
fi
