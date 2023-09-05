#!/bin/bash
set -euo pipefail

this_script="$0"
stash_dir="/stash"
annex_dir="/stash.archive"

function mv-to-annex() {
  # Move a file from /stash to /stash.archive at the same relative path.
  # Moves existing files to a timestamped backup.
  if [[ $# -ne 1 ]]; then
    echo "Usage: $0 filepath"
    exit 1
  fi
  filepath="$(realpath "$1")"
  if [[ ! "$filepath" =~ ^$stash_dir ]]; then
    echo "Error: File should be under $stash_dir"
    exit 1
  fi
  if [[ ! -e "$filepath" ]]; then
    echo "Error: File not found: $filepath"
    exit 1
  fi
  rel_path=${filepath#$stash_dir}
  dst_path="$annex_dir$rel_path"
  mkdir -p "$(dirname "$dst_path")"
  if [[ -e "$dst_path" ]]; then
    if cmp -s "$filepath" "$dst_path"; then
      rm "$filepath"
      echo "$filepath is already at $dst_path"
      exit 0
    else
      timestamp=$(stat -c %Y "$dst_path")
      date_added=$(date -d "@$timestamp" '+%Y_%m_%d-%H%M%S')
      dst_dst_path="$(mktemp "$dst_path.$date_added.XXX")"
      mv "$dst_path" "$dst_dst_path"
      echo "Moved existing $dst_path to $dst_dst_path"
    fi
  fi
  cp -a "$filepath" "$dst_path" && rm "$filepath"
  echo "Moved $filepath to $dst_path"
}

function copy-stash-to-annex() {
  # Copies all files from /stash to /stash.archive at the same relative path.
  # If a file already exists, it is skipped, with the understanding that if the
  # file is ever deleted, [mv-stash-to-annex] will be called on it.
  find "$stash_dir" -type f -print0 | while IFS= read -r -d $'\0' file; do
    rel_path="${file#$stash_dir}"
    dst_path="$annex_dir$rel_path"
    if [[ ! -e "$dst_path" ]]; then
      #echo "$rel_path --> $dst_path"
      mkdir -p "$(dirname "$dst_path")"
      cp -a "$file" "$dst_path"
    fi
  done
}

function sync-annex() {
  cd "$annex_dir"
  git annex add .
  git annex sync --content
}

if [[ $# -eq 0 ]]; then
  echo "commands are:"
  grep -E "^function" $this_script | cut -d' ' -f2 | sed 's/..$//'
  exit 1
fi

"$@"
