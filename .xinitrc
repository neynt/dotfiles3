[ -f ~/.xprofile ] && . ~/.xprofile
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
setxkbmap -option compose:ralt
setxkbmap -option ctrl:nocaps
redshift-gtk &
keepassxc &
discord &
ibus-daemon -drx
screenshot-loop.sh &
dbus-launch awesome
