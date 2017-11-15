#!/usr/bin/env python3
# Test song recognition starting at random points.
# Run from a directory that contains only the desired sound files.

import math
import os
import glob
import subprocess
import random

FNULL = open(os.devnull, 'w')
all_songs = glob.glob('*')
song_length = {}

for song in all_songs:
    # this some real brittle code right here
    result = subprocess.run(['ffprobe', song], stdout=FNULL, stderr=subprocess.PIPE)
    dur_line = [l for l in result.stderr.decode('utf-8').splitlines() if 'Duration:' in l][0]
    dur_str = dur_line.split()[1][:-1]
    h, m, s = map(float, dur_str.split(':'))
    length_s = math.floor(h*3600 + m*60 + s)
    song_length[song] = length_s

songs_left = list(all_songs)
songs_cur = []

while True:
    if not songs_cur:
        songs_cur = random.sample(songs_left, min(len(songs_left), 5))
    if not songs_cur:
        print('Congratulations.')
        break
    song = songs_cur.pop()
    try:
        start_time = random.randint(1, song_length[song] - 11)
        end_time = start_time + 10
        subprocess.run(['mpv',
            '--no-video',
            '--start=%d' % start_time,
            '--end=%d' % end_time,
            song], stdout=subprocess.PIPE, stderr=FNULL)
    except KeyboardInterrupt:
        pass
    print()
    print(song)
    print('Enter: got it! ^C: nope. Q: quit.')
    try:
        if input().lower().startswith('q'):
            break
        else:
            songs_left.remove(song)
            print('%d remaining' % len(songs_left))
    except KeyboardInterrupt:
        pass
