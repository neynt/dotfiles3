#!/usr/bin/env bash
# Watches for new windows and moves agent-spawned browsers to workspace 10.
# Identifies agent browsers by checking if the process was launched with a
# --user-data-dir under ~/.toebeans/

SOCKET="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"

socat -u "UNIX-CONNECT:$SOCKET" - | while IFS= read -r event; do
  # openwindow>>ADDR,WORKSPACE,CLASS,TITLE
  if [[ "$event" == openwindow\>\>* ]]; then
    addr="${event#openwindow>>}"
    addr="${addr%%,*}"

    # get the PID from hyprctl
    pid=$(hyprctl clients -j | jq -r ".[] | select(.address == \"0x$addr\") | .pid")
    [[ -z "$pid" || "$pid" == "null" ]] && continue

    # check if the process cmdline contains .toebeans
    cmdline=$(tr '\0' ' ' < "/proc/$pid/cmdline" 2>/dev/null)
    if [[ "$cmdline" == *".toebeans"* ]]; then
      hyprctl --batch "dispatch movetoworkspacesilent 10,address:0x$addr; dispatch setfloating address:0x$addr; dispatch resizewindowpixel exact 1024 768,address:0x$addr"
    fi
  fi
done
