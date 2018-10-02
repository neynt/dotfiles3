#!/bin/bash

echo -n "Total TODOs created: "
git grep 'TODO' $(git rev-list --all) | cut -c 42- | sort | uniq | wc -l
echo -n "Current TODOs: "
git grep 'TODO' | cut -c 42- | sort | uniq | wc -l
