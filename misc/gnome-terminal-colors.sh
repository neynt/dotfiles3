#!/bin/bash
PROFILE_ID="$(dconf list /org/gnome/terminal/legacy/profiles:/ | head -n1 | xargs)"
KEY="/org/gnome/terminal/legacy/profiles:/$PROFILE_ID"
KEY="${KEY%/}"

dconf write "$KEY/background-color" "'rgb(0,0,0)'"
dconf write "$KEY/foreground-color" "'rgb(204,204,204)'"
#dconf write "$KEY/palette" "['rgb(57,57,57)', 'rgb(202,103,74)', 'rgb(150,169,103)', 'rgb(211,169,74)', 'rgb(87,120,193)', 'rgb(156,53,172)', 'rgb(110,181,243)', 'rgb(169,169,169)', 'rgb(83,85,81)', 'rgb(234,40,40)', 'rgb(135,221,50)', 'rgb(247,228,77)', 'rgb(111,155,202)', 'rgb(169,124,164)', 'rgb(50,221,221)', 'rgb(233,233,231)']"
