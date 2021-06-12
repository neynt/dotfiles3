#!/usr/bin/env python3

import argparse
import sys
import spacy
import random
import os

parser = argparse.ArgumentParser(description='subtitle utilities')
parser.add_argument('filename', type=str, help='input srt file')
parser.add_argument('--brain', type=str, help='brain file', required=True)

unwanted_pos = set(['SPACE', 'SYM', 'PUNCT', 'PART', 'ADP'])

def main():
    args = parser.parse_args()
    data = open(args.filename).read()
    try:
        known = set(open(args.brain).read().splitlines())
    except OSError:
        known = set()
    blocks = data.split('\n\n')
    lines = []
    for block in blocks:
        lines.append(''.join(block.splitlines()[2:]))
    text = '\n'.join(lines)
    nlp = spacy.load('ja_core_news_md')
    doc = nlp(text)
    try:
        tokens = []
        for token in doc:
            if token.pos_ not in unwanted_pos and token.lemma_ not in known:
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
                        os.system(f'grep --color=always -C1 "{token.text}" "{args.filename}"')
                    elif cmd == '':
                        break
                    else:
                        print('?')
                known.add(lemma)
    except:
        print('ok bye')
    finally:
        open(args.brain, 'w').write('\n'.join(sorted(known)))

if __name__ == '__main__':
    main()
