#!/bin/bash

# 10 workspaces
gsettings set org.gnome.desktop.wm.preferences num-workspaces 10

# Super+n goes to workspace n
for ws in {1..10}; do
  key=$(( ws % 10 ))
  gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-${ws} "['<Super><Shift>${key}']"
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-${ws} "['<Super>${key}']"
done

# Resize with right button
gsettings set org.gnome.desktop.wm.preferences resize-with-right-button true

# Save screenshots to Dropbox
gsettings set org.gnome.gnome-screenshot auto-save-directory 'file:///home/neynt/Dropbox/Screenshots/'
