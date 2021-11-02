#!/bin/bash
[ -f ~/.xprofile ] && . ~/.xprofile
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export PATH=~/bin/:$PATH
setxkbmap -option compose:ralt,ctrl:nocaps
redshift-gtk -l 40.72:-74.02 -t 6500:4500 &
keepassxc &
discord --no-sandbox &
# probably needs DISPLAY variable, just run from awesomewm
#ibus-daemon -drx
#(sleep 10 && ibus-daemon -drx) &
screenshot-loop.sh &
cbatticon &
plover &
#/loot/apps/dogecoin-1.14.3-linux/bin/dogecoin-qt &
#dbus-launch i3
dbus-launch awesome
