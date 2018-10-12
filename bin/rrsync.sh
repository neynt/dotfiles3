#!/bin/bash
FILE="$1"
HOST1="$2"
HOST2="$3"
TMPFILE="$(mktemp)"
rsync $HOST1:$FILE $TMPFILE
rsync $TMPFILE $HOST2:$FILE
