#!/usr/bin/env python3

# Tools for managing a music collection.
#
# Step 1: raw-video/*.{webm,mkv}, raw-audio/**/*.{m4a,mp3,flac}
# Step 2: .intermediate/audio-transcoded/**/*.mp3
# Step 3: result/**/*.mp3

from collections import Counter
from multiprocessing import Pool
from pathlib import Path
import glob
import itertools
import math
import os
import random
import shutil
import subprocess
import sys

def normalize(name):
    return ''.join(c for c in name if c.isalnum())

def basename_no_ext(path):
    return path.split('/')[-1].rsplit('.', 1)[0]

def get_metadata(path, field):
    print('get_metadata', path, field)
    data = subprocess.run(['exiftool', '-' + field, '-b', path], stdout=subprocess.PIPE).stdout.decode('utf-8', 'ignore')
    if len(data) == 0:
        return None
    return data

def matches(n1, n2):
    return n1 and n2 and normalize(n1) == normalize(n2)

def file_duration(file):
    return float(get_metadata(file, 'Duration'))

def play_file(file, start_at=0, duration=2):
    subprocess.run([
        'mpv',
        #'--lavfi-complex=[aid1]asplit[ao][a]; [a]showcqt=fps=60:gamma=2.0:gamma2=5:count=6[vo]',
        '--really-quiet',
        file,
        f'--start={start_at}',
        f'--length={duration}',
        ])

def blind_test(file_glob):
    files = glob.glob(file_glob)
    results = []
    print('Welcome to the test. Files are:')
    for file in files:
        print(file)
    done = False
    while not done:
        file_a, file_b = random.sample(files, 2)
        max_dur = min(file_duration(file_a), file_duration(file_b))
        start_at = random.uniform(0.0, max_dur - 2.0)
        result = None
        while True:
            print('[ a: play a | b: play b | d: done | else: record result ]')
            cmd = input()
            if cmd == 'a':
                play_file(file_a, start_at)
            elif cmd == 'b':
                play_file(file_b, start_at)
            elif cmd == 'd':
                done = True
                break
            else:
                result = cmd
                break
        print(f'file a: {file_a}')
        print(f'file b: {file_b}')
        print(f'start at: {start_at}')
        if result:
            results.append((file_a, file_b, start_at, result))

    print('file_a,file_b,start_at,result')
    for file_a, file_b, start_at, result in results:
        print(f'{file_a},{file_b},{start_at},{result}')

def slam_mp3_with_changed_metadata(path, result_path, fields):
    args = sum([['-metadata', f'{field}={value}'] for field, value in fields], [])
    subprocess.run(
        ['ffmpeg', '-i', path, '-c', 'copy'] + args + [result_path],
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE
    )

def slam_mp3_with_normalized_metadata(path: Path, result_path: Path):
    # TODO: Ignore first two parts of path. This is bad.
    path_parts = path.parts[2:]
    artist, album, track, title = None, None, None, None
    if len(path_parts) == 1:
        parts = path.stem.split(' - ')
        if len(parts) == 4: artist, album, track, title = parts
        elif len(parts) == 3: artist, album, title = parts
        elif len(parts) == 2: artist, title = parts
        else: print('ERROR: invalid file name at top level')
    elif len(path_parts) == 2:
        dir_parts = path_parts[0].split(' - ')
        if len(dir_parts) == 2: artist, album = dir_parts
        elif len(dir_parts) == 1: artist, album = 'Various Artists', dir_parts[0]
        file_parts = path.stem.split(' - ')
        if len(file_parts) == 2: track, title = file_parts
        elif len(file_parts) == 1: title = file_parts
        else: print('ERROR: invalid file name in subdir')
    else:
        print('ERROR: invalid dir name')

    # TODO: Speed this up by making only one exiftool call.
    cur_artist, cur_album, cur_track, cur_title = (
        [get_metadata(path, field) for field in ['Artist', 'Album', 'Track', 'Title']]
    )

    fields = []
    if artist and not matches(artist, cur_artist): fields.append(('Artist', artist))
    if album and not matches(album, cur_album): fields.append(('Album', album))
    if track and not matches(track, cur_track): fields.append(('Track', track))
    if title and not matches(title, cur_title): fields.append(('Title', title))
    if fields:
        print(f'Copying {path} -> {result_path}\n  with metadata: {fields}')
        slam_mp3_with_changed_metadata(path, result_path, fields)
    else:
        print(f'Copying {path} -> {result_path}')
        shutil.copyfile(path, result_path)

def transcode_audio_to_audio(file, output):
    print(f'Transcoding {file} -> {output}')
    subprocess.run(
        [
            'ffmpeg',
            '-i', file,
            '-codec:v', 'copy',
            '-codec:a', 'libmp3lame',
            '-q:a', '4',
            output,
        ],
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
    )

def transcode_video_to_audio(file, output):
    print(f'Transcoding {file} -> {output}')
    subprocess.run(
        [
            'ffmpeg',
            '-i', file,
            '-vn',
            '-codec:a', 'libmp3lame',
            '-q:a', '4',
            output,
        ],
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
    )

def get_raw_audios(): return map(Path, sum((glob.glob(f'raw-audio/**/*.{ext}', recursive=True) for ext in ['mp3', 'm4a', 'flac']), []))
def get_raw_videos(): return map(Path, sum((glob.glob(f'raw-video/*.{ext}') for ext in ['webm', 'mkv']), []))
def get_transcoded_audios(): return map(Path, glob.glob('.intermediate/audio-transcoded/**/*.mp3', recursive=True))
def get_result_audios(): return map(Path, glob.glob('result/**/*.mp3', recursive=True))
def raw_file_to_transcoded_audio(path): return (Path('.intermediate/audio-transcoded') / Path(*path.parts[1:])).with_suffix('.mp3')
def transcoded_audio_to_result_audio(path): return (Path('result') / Path(*path.parts[2:]))

def trim_edge(get_raw_fns, get_result_fns):
    raw_results = sum((list(map(raw_to_result, get_raws())) for get_raws, raw_to_result in get_raw_fns), [])
    conflicts = [item for item, count in Counter(raw_results).items() if count > 1]
    results = sum((list(f()) for f in get_result_fns), [])
    extras = set(results) - set(raw_results)
    if conflicts:
        print('Warning: conflicts.', conflicts)
        raise Exception('conflicts')
    for extra in extras:
        print(f'Removing extra file: {extra}')
        os.remove(extra)

def trim_unneeded_audio_transcoded():
    trim_edge(
        [
            (get_raw_videos, raw_file_to_transcoded_audio),
            (get_raw_audios, raw_file_to_transcoded_audio),
        ],
        [get_transcoded_audios],
    )

def trim_unneeded_audio_results():
    trim_edge(
        [(get_transcoded_audios, transcoded_audio_to_result_audio)],
        [get_result_audios]
    )

def slam(get_raw, raw_to_next_step, process):
    work = []
    for raw in get_raw():
        next_step = raw_to_next_step(raw)
        if not next_step.exists() or next_step.stat().st_mtime < raw.stat().st_mtime:
            next_step.parent.mkdir(parents=True, exist_ok=True)
            work.append((raw, next_step))
    with Pool(4) as pool:
        pool.starmap(process, work)

def slam_audio_to_audio_transcoded(): slam(get_raw_audios, raw_file_to_transcoded_audio, transcode_audio_to_audio)
# TODO: keep original youtube url in video files
def slam_video_to_audio_transcoded(): slam(get_raw_videos, raw_file_to_transcoded_audio, transcode_video_to_audio)
def slam_audio_transcoded_to_audio(): slam(get_transcoded_audios, transcoded_audio_to_result_audio, slam_mp3_with_normalized_metadata)

def slam_all():
    trim_unneeded_audio_transcoded()
    trim_unneeded_audio_results()
    slam_video_to_audio_transcoded()
    slam_audio_to_audio_transcoded()
    slam_audio_transcoded_to_audio()

subcommands = [
    ('slam-all', slam_all),
    ('blind-test', blind_test),
]

def main():
    if len(sys.argv) < 2:
        print(f'Usage: {sys.argv[0]} subcommand')
        print('Subcommands are:')
        for name, _ in subcommands:
            print(name)
        sys.exit(1)
    cmd = sys.argv[1]
    subcommands_dict = dict(subcommands)
    if cmd in subcommands_dict:
        subcommands_dict[cmd](*sys.argv[2:])

if __name__ == '__main__':
    main()
