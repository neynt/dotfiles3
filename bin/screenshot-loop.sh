#!/bin/bash
set -euo pipefail

SCREENSHOTS_DIR=~/Dropbox/Screenshots

while true; do
  TIMESTAMP="$(date +%Y-%m-%d.%H.%M.%S)"
  FILENAME=$SCREENSHOTS_DIR/$TIMESTAMP.screenshot.png
  maim -u $FILENAME
  sleep 1800
done
