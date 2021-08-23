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
    echo "Linking directory: $ln_source -> $ln_target"
  elif [[ -f "$ln_target" ]]; then
    rm -f -i $ln_source || true
    echo "Linking file $ln_source -> $ln_target"
  else
    echo "$filename is not a file or directory" >&2
  fi
  mkdir -p "$(dirname $ln_source)"
  ln -s $ln_target $ln_source
done
