#!/bin/bash

path="/sys/class/backlight/intel_backlight"
cur="$(cat $path/brightness)"
max="$(cat $path/max_brightness)"
if [[ "$1" = "up" ]]; then
  new=$((cur * 150 / 100 + 10))
  if [[ $new -gt $max ]]; then
    new=$max
  fi
  echo $new > $path/brightness
elif [[ "$1" = "down" ]]; then
  new=$(((cur - 10) * 100 / 150 + 1))
  if [[ $new -le 0 ]]; then
    new=1
  fi
  echo $new > $path/brightness
else
  echo "No argument."
  exit 1
fi

notify-send --urgency low "Brightness: $new / $max"
