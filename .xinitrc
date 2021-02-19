[ -f ~/.xprofile ] && . ~/.xprofile
setxkbmap -option compose:ralt
setxkbmap -option ctrl:nocaps
redshift-gtk &
dbus-launch awesome
