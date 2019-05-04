#!/bin/bash
DIR=~/code/diary/diary
EXT=.md

cd $DIR
TODAY="$(date -d '3 hours ago' +%F)$EXT"
$EDITOR $TODAY
if [[ -f $TODAY ]]; then
  echo 'You wrote' $(wc -w < $TODAY) 'words.'
fi
