#!/bin/bash
GAMMA=1.0
xcalib -a -c
xcalib -a -red $GAMMA 0 25 -green $GAMMA 0 20 -blue $GAMMA 0 15
