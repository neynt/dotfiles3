#!/usr/bin/env python3

# srt.py -- extract vocabulary words from srt subtitles with the ability to
# pull up definitions and grep for the words used in context

import argparse
import collections
import os
import random
import spacy
import subprocess
import sys

parser = argparse.ArgumentParser(description='subtitle utilities')
parser.add_argument('filename', type=str, nargs='*', help='input srt files')
parser.add_argument('--brain', type=str, help='brain file')
parser.add_argument('--min-count', type=int, help='only show words that occur at least this many times', default=2)

unwanted_pos = set(['SPACE', 'SYM', 'PUNCT', 'PART', 'ADP'])

def load_srt(filename):
    data = open(filename).read()
    blocks = data.split('\n\n')
    lines = []
    for block in blocks:
        lines.append(''.join(block.splitlines()[2:]))
    return lines

def main():
    args = parser.parse_args()
    brain = args.brain or os.path.expanduser('~/srt.brain')
    try:
        known = set(open(brain).read().splitlines())
    except OSError:
        known = set()
    text = '\n'.join(sum((load_srt(filename) for filename in args.filename), []))
    nlp = spacy.load('ja_core_news_md')
    doc = nlp(text)
    try:
        all_tokens = []
        for token in doc:
            all_tokens.append(token)
        token_counts = collections.Counter(token.lemma_ for token in all_tokens)
        seen_lemmas = set()
        tokens = []
        for token in all_tokens:
            if token.pos_ in unwanted_pos: continue
            if token.lemma_ in known: continue
            #if token.lemma_ in seen_lemmas: continue
            if token_counts[token.lemma_] < args.min_count: continue
            seen_lemmas.add(token.lemma_)
            tokens.append(token)
        random.shuffle(tokens)
        while tokens:
            token = tokens.pop()
            lemma = token.lemma_
            if lemma not in known:
                print(len(tokens), lemma, token.pos_)
                print('https://jisho.org/search/' + lemma)
                print('https://en.wiktionary.org/wiki/' + lemma)
                while True:
                    cmd = input()
                    if cmd == 'd':
                        os.system(f'define {lemma} -l Japanese')
                    elif cmd == 'c':
                        output = subprocess.check_output(['grep', '--color=always', '-C1', token.text] + args.filename)
                        print(output.decode('utf-8'), end='')
                        output = subprocess.check_output(['grep', '--color=never', '-C1', token.text] + args.filename)
                        p = subprocess.run(['xclip', '-in', '-selection', 'clipboard'], input=output)
                    elif cmd == '':
                        break
                    else:
                        print('?')
                known.add(lemma)
    except KeyboardInterrupt:
        print('ok bye')
    except:
        print('whoa')
        raise
    finally:
        f = open(brain, 'w')
        f.write('\n'.join(sorted(known)))
        f.close()

if __name__ == '__main__':
    main()
