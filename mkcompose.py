#!/usr/bin/python3
import unicodedata

keynames = dict([line.split() for line in """
! exclam
' apostrophe
* asterisk
- minus
. period
/ slash
= equal
> greater
_ underscore
| bar
~ asciitilde
\ backslash
( parenleft
) parenright
""".strip().splitlines()])

def pairs(data):
    return [line.split() for line in data.strip().splitlines()]

# Math stuff
macros = pairs("""
-~       ⁓
sq       √
3sq      ∛
4sq      ∜
inf      ∞
*x       ⨯
*.       ⋅
del      ∇
part     ∂
==       ≡
int      ∫
uint     ⨛
lint     ⨜
iint     ∬
iiint    ∭
iiiint   ⨌
""")

# Sets
macros += pairs("""
|C       ℂ
|N       ℕ
|P       ℙ
|Q       ℚ
|R       ℝ
|Z       ℤ
not      ¬
AA       ∀
EE       ∃
land     ∧
lor      ∨
|-       ⊦
|=       ⊧
|>       ▷
lin      ∈
!lin     ∉
(_       ⊆
((       ⊂
""")

# Greek letters
macros += pairs("""
mga       α
mgb       β
mgg       γ
mgd       δ
mge       ε
mgz       ζ
mgh       η
mgv       θ
mgi       ι
mgk       κ
mgl       λ
mgm       μ
mgn       ν
\\xi      ξ
\\omicron ο
mgp       π
mgr       ρ
mgs       σ
mgt       τ
mgu       υ
mgj       φ
mgf       ϕ
mgc       χ
mgy       ψ
mgo       ω
mgA       Α
mgB       Β
mgG       Γ
mgD       Δ
mgE       Ε
mgZ       Ζ
mgH       Η
mgV       Θ
mgI       Ι
mgK       Κ
mgL       Λ
mgM       Μ
mgN       Ν
\\Xi      Ξ
\\Omicron Ο
mgP       Π
mgR       Ρ
mgS       Σ
mgT       Τ
mgU       Υ
mgF       Φ
mgC       Χ
mgY       Ψ
mgO       Ω
""")

print('include "/usr/share/X11/locale/en_US.UTF-8/Compose"')
for seq, char in macros:
    seq_codes = ['Multi_key'] + [keynames.get(c, c) for c in seq]
    xcmp_seq = ' '.join('<%s>' % s for s in seq_codes[:5])
    unicode_name = unicodedata.name(char)
    print('%-40s: "%c" U%s  # %s' % (xcmp_seq, char, hex(ord(char))[2:].upper(), unicode_name))
