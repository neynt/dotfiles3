#!/bin/bash
PROFILE_ID="$(dconf list /org/gnome/terminal/legacy/profiles:/ | head -n1 | xargs)"
KEY="/org/gnome/terminal/legacy/profiles:/$PROFILE_ID"
KEY="${KEY%/}"

echo $KEY

dconf write "$KEY/background-color" "'rgb(0,0,0)'"
dconf write "$KEY/foreground-color" "'rgb(233,233,233)'"
dconf write "$KEY/palette" "['rgb(34,34,34)', 'rgb(199,86,70)', 'rgb(142,179,59)', 'rgb(208,176,60)', 'rgb(114,179,204)', 'rgb(200,160,209)', 'rgb(33,134,147)', 'rgb(176,176,176)', 'rgb(93,93,93)', 'rgb(224,150,144)', 'rgb(205,238,105)', 'rgb(255,227,119)', 'rgb(156,217,240)', 'rgb(251,177,249)', 'rgb(119,223,216)', 'rgb(255,255,255)']"
