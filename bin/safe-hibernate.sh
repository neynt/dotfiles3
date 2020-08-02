#!/bin/bash
sudo umount /loot
MOUNT_LOOT=$?
sudo systemctl hibernate
if [[ $MOUNT_LOOT == 0 ]]; then sudo mount /loot; fi
