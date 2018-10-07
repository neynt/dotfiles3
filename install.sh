#!/bin/bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ "$#" -eq 0 ]; then
  echo "Usage: ./install.sh FILES_OR_DIRS" >&2
  exit 1
fi

for filename in "$@"; do
  ln_target="$DIR/$filename"
  ln_source="$HOME/$filename"

  # Remove slash at end of directory, so rm -rf doesn't recurse into the real
  # files
  ln_source=${ln_source%/}

  if [[ -d "$ln_target" ]]; then
    rm -rf -i $ln_source || true
    mkdir -p "$(dirname $ln_source)"
    ln -s $ln_target $ln_source
    echo "linked $ln_source -> $ln_target (directory)"
  elif [[ -f "$ln_target" ]]; then
    rm -f -i $ln_source || true
    ln -s $ln_target $ln_source
    echo "linked $ln_source -> $ln_target (file)"
  else
    echo "$filename is not a file or directory" >&2
  fi
done
