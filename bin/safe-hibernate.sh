#!/bin/bash
set -euo pipefail
sudo umount /loot
sudo systemctl hibernate
sudo mount /loot
