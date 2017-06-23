#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
src="$1"
rel_dest="${src#$HOME}"
rel_dest="${rel_dest#/}"
rel_dest="${rel_dest%/}"
dest="$DIR/$rel_dest"

echo "$src --> $rel_dest"
mkdir -p $(dirname $dest)
cp -r $src $dest
echo "Now take control with:"
echo "./install.sh $rel_dest"
