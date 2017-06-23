#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "bspwm"
rm -Ir ~/.config/bspwm
ln -s $DIR/.config/bspwm ~/.config/bspwm

echo "sxhkd"
rm -Ir ~/.config/sxhkd
ln -s $DIR/.config/sxhkd ~/.config/sxhkd

echo ".xprofile"
rm -if ~/.xprofile
ln -s $DIR/.xprofile ~/.xprofile

echo ".vimrc"
rm -if ~/.vimrc
ln -s $DIR/.vimrc ~/.vimrc

echo ".tmux.conf"
rm -if ~/.tmux.conf
ln -s $DIR/.tmux.conf ~/.tmux.conf

echo "done."
