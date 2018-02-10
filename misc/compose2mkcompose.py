# Reads an existing .XCompose file and converts it to mkcompose format.
stuff = [l.split() for l in open('.XCompose').readlines()]
macros = [line for line in stuff if line and line[0] == '<Multi_key>']

keynames = dict([line.split() for line in """
- minus
~ asciitilde
* asterisk
. period
= equal
| bar
> greater
! exclam
""".strip().splitlines()])

keycodes = {v:k for k,v in keynames.items()}
print(keycodes)

for m in macros:
    c = m.index(':')
    keys = [x[1:-1] for x in m[1:c]]
    seq = ''.join(keycodes.get(k, k) for k in keys)
    char = m[c+1][1]
    print("%-8s %s" % (seq, char))
