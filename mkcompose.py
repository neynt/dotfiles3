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
\\alpha   α
\\beta    β
\\gamma   γ
\\delta   δ
\\epsilon ε
\\zeta    ζ
\\eta     η
\\theta   θ
\\iota    ι
\\kappa   κ
\\lambda  λ
\\mu      μ
\\nu      ν
\\xi      ξ
\\omicron ο
\\pi      π
\\rho     ρ
\\sigma   σ
\\tau     τ
\\upsilon υ
\\phi     φ
\\chi     χ
\\psi     ψ
\\omega   ω
\\Alpha   Α
\\Beta    Β
\\Gamma   Γ
\\Delta   Δ
\\Epsilon Ε
\\Zeta    Ζ
\\Eta     Η
\\Theta   Θ
\\Iota    Ι
\\Kappa   Κ
\\Lambda  Λ
\\Mu      Μ
\\Nu      Ν
\\Xi      Ξ
\\Omicron Ο
\\Pi      Π
\\Rho     Ρ
\\Sigma   Σ
\\Tau     Τ
\\Upsilon Υ
\\Phi     Φ
\\Chi     Χ
\\Psi     Ψ
\\Omega   Ω
""")

print('include "/usr/share/X11/locale/en_US.UTF-8/Compose"')
for seq, char in macros:
    seq_codes = ['Multi_key'] + [keynames.get(c, c) for c in seq]
    xcmp_seq = ' '.join('<%s>' % s for s in seq_codes[:5])
    unicode_name = unicodedata.name(char)
    print('%-40s: "%c" U%s  # %s' % (xcmp_seq, char, hex(ord(char))[2:].upper(), unicode_name))
