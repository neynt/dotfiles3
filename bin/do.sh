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

function trigger() {
  # Example: trigger sage plots.sage
  # will run 'sage plots.sage' whenever 'plots.sage' changes.
  script_file="${@: -1}"
  while fswatch -1  > /dev/null; do
    $@
  done
}

function trigger-in() {
  # Example: trigger-in python3 script.py data.in 
  # will run 'sage plots.sage' whenever 'plots.sage' or data.in changes.
  set +e
  input_file="${@: -1}"
  script_file="${@:(-2):1}"
  script_command="${@:1:$#-1}"
  while :; do
    clear
    $script_command < $input_file
    fswatch -1 "$script_file" > /dev/null
    clear
  done
}

if [[ $# -eq 0 ]]; then
  echo "commands are:"
  grep -E "^function" "$this_script" | cut -d' ' -f2 | sed 's/..$//'
  exit 1
fi

"$@"
