#!/usr/bin/env python3
# srt.py -- extract vocabulary words from srt subtitles with the ability to
# pull up definitions and grep for the words used in context

import click
import collections
import dataclasses
import datetime
import functools
import heapq
import os
import random
import spacy
import sqlite_utils
import subprocess


def timedelta_to_str(time: datetime.timedelta):
    return '{:02d}:{:02d}:{:02d}'.format(time.seconds // 3600, (time.seconds // 60) % 60, time.seconds % 60)


def parse_time_interval(time_interval: str):
    # time_interval is like 00:00:25,984
    time = datetime.datetime.strptime(time_interval, '%H:%M:%S,%f')
    time = datetime.timedelta(hours=time.hour, minutes=time.minute, seconds=time.second, microseconds=time.microsecond)
    return time


def parse_srt_time_range(time_range: str):
    # time_range is like 00:00:25,984 --> 00:00:26,860
    start_time, end_time = time_range.split(' --> ')
    start_time = parse_time_interval(start_time)
    end_time = parse_time_interval(end_time)
    return (start_time, end_time)

@dataclasses.dataclass
class SrtEntry:
    index: int
    start_time: datetime.timedelta
    end_time: datetime.timedelta
    time: str
    lines: list[str]

    @classmethod
    def load_from_file(cls, filename) -> list['SrtEntry']:
        data = open(filename).read()
        blocks = data.split('\n\n')
        entries = []
        for block in blocks:
            lines = block.split('\n', 2)
            if len(lines) < 3:
                continue
            index, time, lines = lines
            index = int(index)
            start_time, end_time = parse_srt_time_range(time)
            lines = lines.splitlines()
            entries.append(cls(index, start_time, end_time, time, lines))
        return entries

db = sqlite_utils.Database(os.path.expanduser('~/srt.db'))

@functools.cache
def words() -> sqlite_utils.db.Table: return db['words']  # type: ignore

@functools.cache
def lines() -> sqlite_utils.db.Table: return db['lines']  # type: ignore

def has_seen_word(word):
    result = db.query('''
        select * from words where lemma = :lemma
    ''', {'lemma': word})
    return len(list(result)) > 0

def mark_seen_word(word):
    words().insert({'timestamp': datetime.datetime.now(), 'lemma': word})

def has_seen_line(line):
    result = db.query('''select * from lines where text = :text''', {'text': line})
    return len(list(result)) > 0

def mark_seen_line(line):
    lines().insert({'timestamp': datetime.datetime.now(), 'text': line})

def grep(text, files, *, context=1):
    output = subprocess.check_output(['grep', '--color=always', f'-C{context}', text] + files)
    print(output.decode('utf-8'), end='')

@click.group()
def cli():
    pass

@cli.command()
def fix_db():
    words().create(
        {"lemma": str, "timestamp": str},
        transform=True)
    lines().create(
        {"text": str, "timestamp": str},
        transform=True)

unwanted_pos = set(['SPACE', 'SYM', 'PUNCT', 'PART', 'ADP'])

@cli.command()
@click.argument('srt_file', type=click.Path(exists=True))
def srt_to_script(*, srt_file):
    entries = SrtEntry.load_from_file(srt_file)
    text = []
    for entry in entries:
        text.extend(entry.lines)
    print('\n'.join(text))


@cli.command()
@click.argument('srt_files', type=click.Path(exists=True), nargs=-1)
def line_up_srts(*, srt_files):
    heap = []
    for srt_file in srt_files:
        for entry in SrtEntry.load_from_file(srt_file):
            heapq.heappush(heap, (entry.start_time, srt_file, entry))
    rows = []
    while heap:
        next_row = collections.defaultdict(list)
        row_time = heap[0][0]
        while heap:
            time, srt_file, entry = heap[0]
            if time - row_time > datetime.timedelta(seconds=3):
                break
            heapq.heappop(heap)
            next_row[srt_file].extend(entry.lines)
        rows.append((row_time, next_row))
    result_html = []
    result_html.append('<table>')
    result_html.append('<tr>')
    result_html.append('<th>Time</th>')
    for srt_file in srt_files:
        result_html.append(f'<th>{srt_file}</th>')
    result_html.append('</tr>\n')
    for (row_time, row) in rows:
        result_html.append('<tr>')
        result_html.append(f'<td>{timedelta_to_str(row_time)}</td>')
        for srt_file in srt_files:
            result_html.append('<td>')
            result_html.append('<br>'.join(row[srt_file]))
            result_html.append('</td>')
        result_html.append('</tr>\n')
    result_html.append('</table>')
    print(''.join(result_html))


def quiz_tokens(tokens, grep_files=[]):
    random.shuffle(tokens)
    while tokens:
        token = tokens.pop()
        lemma = token.lemma_
        if has_seen_word(lemma):
            continue
        print(f'{len(tokens)} remaining.  {lemma}  {token.pos_}')
        print('https://jisho.org/search/' + lemma)
        print('https://en.wiktionary.org/wiki/' + lemma)
        try:
            while True:
                cmd = input()
                match cmd:
                    case 'd':
                        print('https://jisho.org/search/' + lemma)
                        print('https://en.wiktionary.org/wiki/' + lemma)
                    case 'c':
                        grep(token.text, grep_files)
                    case '':
                        mark_seen_word(lemma)
                        break
                    case _:
                        print('?')
        except KeyboardInterrupt:
            print()
            print('Ok, bye!')
            break


def quiz_lines(lines, grep_files=[]):
    random.shuffle(lines)
    while lines:
        line = lines.pop()
        if has_seen_line(line):
            continue
        print(f'{len(lines)} lines remaining.')
        grep(line, grep_files, context=1)
        try:
            while True:
                cmd = input()
                match cmd:
                    case '':
                        mark_seen_line(line)
                        break
                    case 'c':
                        grep(line, grep_files, context=2)
                    case _ :
                        print('?')
        except KeyboardInterrupt:
            print()
            print('Ok, bye!')
            break

def text_to_tokens(text):
    """Convert text to tokens. Filter out duplicate and unwanted tokens."""
    nlp = spacy.load('ja_core_news_md')
    doc = nlp(text)
    all_tokens = []
    for token in doc:
        all_tokens.append(token)
    #token_counts = collections.Counter(token.lemma_ for token in all_tokens)
    tokens = []
    for token in all_tokens:
        if token.pos_ in unwanted_pos: continue
        if has_seen_word(token.lemma_): continue
        #if token_counts[token.lemma_] < min_count: continue
        tokens.append(token)
    return tokens


@cli.command()
@click.argument('words_files', type=click.Path(exists=True), nargs=-1)
def learn_words(*, words_files):
    text = '\n'.join(open(words_file).read() for words_file in words_files)
    tokens = text_to_tokens(text)
    quiz_tokens(tokens, grep_files=list(words_files))


@cli.command()
@click.argument('lines_files', type=click.Path(exists=True), nargs=-1)
def learn_lines(*, lines_files):
    text = '\n'.join(open(lines_file).read() for lines_file in lines_files)
    lines = text.splitlines()
    quiz_lines(lines, grep_files=list(lines_files))


if __name__ == '__main__':
    cli()
