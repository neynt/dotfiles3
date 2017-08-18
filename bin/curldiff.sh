#!/bin/bash
OUTPUT=$(mktemp)
GOLDEN=$(mktemp)
URL="$1"
DELAY=69  # seconds
touch $OUTPUT $GOLDEN
curl $URL > $GOLDEN
while true; do
  curl $URL > $OUTPUT
  if ! diff $OUTPUT $GOLDEN; then
    notify-send 'GO GET EM!!'
    google-chrome 'https://quest.pecs.uwaterloo.ca/psp/SS/'
  fi
  sleep $DELAY
done
