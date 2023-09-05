#!/bin/bash
set -euo pipefail

ls -t . | while read -r file; do
  echo "$(du -h $file | sed 's/\t/    /' | head -c6) $(date -r $file)   $(file $file | head -c150)"
done
