#!/bin/bash
lang=jpn+eng
tmp_img="$(mktemp --suffix=.png)"
function on_exit() {
  #rm "$tmp_img"
  exit
}
trap on_exit EXIT
gnome-screenshot --area --file="$tmp_img"
mogrify -modulate 100,0 -resize 400% "$tmp_img"
tesseract -l "$lang" "$tmp_img" - | xsel -bi
echo $tmp_img
exit
