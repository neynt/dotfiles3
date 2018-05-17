#!/bin/bash
# Example: watch.sh
# Thin wrapper around inotifywait that does $2 whenever a file in $1 changes.
# ... because apparently "-e close_write" is too much for me to remember.
while inotifywait -e close_write $1 >/dev/null 2>/dev/null; do
  $2
done
