#!/bin/bash

while IFS='\n' read -r line; do
  define $line
done
