#!/bin/bash
GAMMA=1.0
xcalib -a -c
xcalib -a -red $GAMMA 0 35 -green $GAMMA 0 15 -blue $GAMMA 0 5
