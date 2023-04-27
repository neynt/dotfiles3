#!/bin/bash
set -euo pipefail
this_script="$0"

function push-loot() {
  if nc -z saltblock-arch.local 22 2>/dev/null; then
    echo 'transferring over home network'
    rsync -abviuP --suffix .old "$HOME/loot/" saltblock-arch.local:/loot
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
  set +e
  script_file="${@: -1}"
  while :; do
    clear
    "$@"
    fswatch --latency=0.1 -1 "$script_file" > /dev/null
    clear
  done
}

function trigger-in() {
  # Example: trigger-in python3 script.py data.in 
  # will run 'python3 script.py < data.in' whenever script.py or data.in changes.
  set +e
  input_file="${@: -1}"
  script_file="${@:(-2):1}"
  script_command="${@:1:$#-1}"
  while :; do
    clear
    $script_command < $input_file
    fswatch --latency=0.1 -1 "$script_file" > /dev/null
    clear
  done
}

function compress-dir() {
  tar --zstd -cf "${1%/}.tar.zst" "${1%/}"
  rm -r "$1"
}

function extract-zstd() {
  tar --zstd -xf "$1"
}

function sync-loot-old-with-rsync() {
  # -a: archive mode (-rlptgoD)
  # -b: make backups with --suffix .old
  # -v: verbose
  # -i: itemize changes
  # -u: update; skip files that are newer on receiver
  # -P: keep partially transferred files, show progress
  rsync -abviuP --backup-dir=/mnt/trove/loot-conflicts /loot/ /mnt/trove/loot
}

function sync-annex() {
  git annex add
  git annex sync --content
}

if [[ $# -eq 0 ]]; then
  echo "commands are:"
  grep -E "^function" "$this_script" | cut -d' ' -f2 | sed 's/..$//'
  exit 1
fi

"$@"
