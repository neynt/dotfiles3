#!/bin/bash
for ws in {0..9}; do
  dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-${ws} "['<Super><Shift>${ws}']"
  dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-${ws} "['<Super>${ws}']"
done
