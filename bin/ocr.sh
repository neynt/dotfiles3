#!/bin/bash
tesseract_lang=jpn
tmp_img=$(mktemp)
trap "rm $tmp_img*" EXIT
gnome-screenshot --area --file=$tmp_img.png
mogrify -modulate 100,0 -resize 400% $tmp_img.png
tesseract -l $tesseract_lang $tmp_img.png $tmp_img &> /dev/null
cat $tmp_img.txt | xsel -bi
exit
