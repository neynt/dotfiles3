#!/bin/bash
# Example: trigger.sh sage plots.sage
# will run 'sage plots.sage' whenever 'plots.sage' changes.
while inotifywait -e close_write "${@: -1}" >/dev/null 2>/dev/null; do
  $@
done
