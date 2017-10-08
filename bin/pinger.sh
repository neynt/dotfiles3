#!/bin/bash

i=0
while true; do
  start_time=$(date +%s)
  read -n 1
  end_time=$(date +%s)
  echo "$((end_time - start_time)) sec"
done
