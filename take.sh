#!/bin/bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ "$#" -ne 1 ]; then
  echo "Usage: ./take.sh ~/.existing_dotfile_or_directory" >&2
  exit 1
fi

src="$1"
rel_dest="${src#$HOME}"  # strip home
rel_dest="${rel_dest#/}"  # strip preceding slash
rel_dest="${rel_dest%/}"  # strip following slash
dest="$DIR/$rel_dest"

mkdir -p $(dirname $dest)
cp -r $src $dest
echo "Copied $src --> $dest"
echo "Now taking control with:"
echo "./install.sh $rel_dest"
./install.sh $rel_dest
