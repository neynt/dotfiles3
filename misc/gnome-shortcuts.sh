#!/bin/bash
for ws in {1..10}; do
  key=$(( ws % 10 ))
  dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-${ws} "['<Super><Shift>${key}']"
  dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-${ws} "['<Super>${key}']"
done
