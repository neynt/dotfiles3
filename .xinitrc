[ -f ~/.xprofile ] && . ~/.xprofile
setxkbmap -option compose:ralt
setxkbmap -option ctrl:nocaps
exec awesome
