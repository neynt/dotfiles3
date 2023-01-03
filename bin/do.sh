#!/bin/bash
set -euo pipefail
this_script="$0"

function push-loot() {
  if nc -z saltblock-arch 22 2>/dev/null; then
    echo 'transferring over home network'
    rsync -abviuP --suffix .old "$HOME/loot/" saltblock-arch:/loot
  else
    echo 'transferring over internet'
    rsync -abviuP --suffix .old --port 4202 "$HOME/loot/" saltblock-arch:/loot
  fi
}

function rot13() {
  tr 'A-Za-z' 'N-ZA-Mn-za-m'
}

function caf() {
  sudo pmset -b sleep 0; sudo pmset -b disablesleep 1
}

function decaf() {
  sudo pmset -b sleep 5; sudo pmset -b disablesleep 0
}

if [[ $# -eq 0 ]]; then
  echo "commands are:"
  grep -E "^function" "$this_script" | cut -d' ' -f2 | sed 's/..$//'
  exit 1
fi

"$@"
