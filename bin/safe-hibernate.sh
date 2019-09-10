#!/bin/bash
sudo umount /data
MOUNT_DATA=$?
sudo umount /windows
MOUNT_WINDOWS=$?
sudo systemctl hibernate
if [[ $MOUNT_WINDOWS == 0 ]]; then sudo mount /windows; fi
if [[ $MOUNT_DATA    == 0 ]]; then sudo mount /data;    fi
