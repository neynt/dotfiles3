#!/usr/bin/env python3
import shutil
import glob
import json
import os
from dataclasses import dataclass, field
from collections import defaultdict
from datetime import datetime

files = glob.glob('**/*')

@dataclass
class Photo:
    json: list[str] = field(default_factory=list)
    images: list[str] = field(default_factory=list)
    timestamp: datetime | None = None
    people: list[str] = field(default_factory=list)

grps = defaultdict(Photo)

def extract_exts(file: str) -> tuple[str, set[str]]:
    exts = ['.json', '.jpg', '.JPG', '.jpe', '.png', '.PNG', '.jpeg', '.HEIC',
            '.MP4', '(1)', '(2)', '(3)', '(4)', '-edited', '.', '_I', '_P',
            '_']
    chopped_exts = []
    for _ in range(5):
        for ext in exts:
            if file.endswith(ext):
                chopped_exts.append(ext)
                file = file.removesuffix(ext)
    return file, set(chopped_exts)

for file in files:
    base, chopped_exts = extract_exts(file)
    grp = grps[base]
    if '.json' in chopped_exts:
        grp.json.append(file)
    else:
        grp.images.append(file)

for _ in range(5):
    for name, grp in list(grps.items()):
        if len(grp.json) > 1:
            name1, exts1 = extract_exts(grp.json[0])
            name2, exts2 = extract_exts(grp.json[1])
            diff = max([exts1 - exts2, exts2 - exts1], key=len)
            diff: str = next(iter(diff))
            grp.json = [json for json in grp.json if diff not in json]
            grp.images = [image for image in grp.images if diff not in image]
            new_grp = grps[name + diff]
            new_grp.json = [json for json in grp.json if diff in json]
            new_grp.images = [image for image in grp.images if diff in image]

for name, grp in grps.items():
    if grp.json and grp.images:
        j = json.load(open(grp.json[0]))
        timestamp = datetime.fromtimestamp(int(j['photoTakenTime']['timestamp']))
        grp.timestamp = timestamp
        if 'people' in j:
            grp.people = [p['name'] for p in j['people']]
    else:
        pass

if os.path.isdir('/Users/neynt/gphoto'):
    shutil.rmtree('/Users/neynt/gphoto')
if os.path.isdir('/Users/neynt/gphoto-by-person'):
    shutil.rmtree('/Users/neynt/gphoto-by-person')
photos_by_timestamp = sorted([g for g in grps.values() if g.images], key=lambda g:g.timestamp or datetime.fromtimestamp(0))
for photo in photos_by_timestamp:
    print(photo)
    if not photo.json: continue
    basename, _ = extract_exts(photo.json[0])
    basename = os.path.basename(basename)
    for img in photo.images:
        print(img)
        if '.' not in img: continue
        filebase, ext = img.rsplit('.', 1)
        filebase = os.path.basename(filebase)
        if photo.timestamp:
            date_part = f'{photo.timestamp.year}/{photo.timestamp.month:02d}'
            date_str = f'{photo.timestamp.strftime("%Y-%m-%d")}'
        else:
            date_part = 'None'
            date_str = 'None'
        dated_dst_dir = f'/Users/neynt/gphoto/{date_part}'
        filename = f'{date_str}.{filebase}.{ext}'
        os.makedirs(dated_dst_dir, exist_ok=True)
        linkpath = f'{dated_dst_dir}/{filename}'

        try:
            os.symlink(os.path.realpath(img), linkpath)
        except FileExistsError:
            print(f'exists: {linkpath}')

        if ext not in ['MP4', 'mp4', 'MP']:
            for person in photo.people:
                person_dst_dir = f'/Users/neynt/gphoto-by-person/{person}'
                os.makedirs(person_dst_dir, exist_ok=True)
                try:
                    os.symlink(os.path.realpath(img), f'{person_dst_dir}/{filename}')
                except FileExistsError:
                    print(f'exists: {linkpath}')
