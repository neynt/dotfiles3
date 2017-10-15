#!/usr/bin/python3
letters = 'abcdefghijklmnopqrstuvwxyz'
spellings = '''a bee cee dee e ef gee
aitch i jay kay el em en o pee cue ar
ess tee u vee double-u ex wy zee'''.split()

mapping = {l:s for l,s in zip(letters, spellings)}
mapping[' '] = 'space'
mapping['\''] = 'apostrophe'
mapping['.'] = 'period'

reverse_mapping = {b:a for a,b in mapping.items()}

def spellout(word):
    return ' '.join(mapping[c] if c in mapping else c for c in ' '.join(word.split()))

def spellin(spelling):
    return ''.join(reverse_mapping[c] if c in reverse_mapping else c for c in spelling.split())

if __name__ == '__main__':
    while True:
        print(spellout(input()))
