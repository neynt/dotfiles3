# additional functions (mainly my prompt)
fpath=( "$HOME/.zsh" $fpath )

if [[ -f ~/.sharedrc ]]; then
  source ~/.sharedrc
fi

if [[ -f ~/.sharedrc.local ]]; then
  source ~/.sharedrc.local
fi

# env vars
[[ ! -r ~/.opam/opam-init/init.zsh ]] || source ~/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

# aliases
#alias diff="colordiff"
alias ls="ls -F --color=auto"
alias grep="grep --color=auto"
alias tmux="tmux -2"
alias ..="cd .."
alias ...="cd ../.."
function ssht() { ssh -tt "$@" 'zsh -c "tmux attach -u || tmux new -u"' }
function mypandoc() { pandoc -V geometry:margin=1in $@ }
function venv() { source venv/bin/activate }
#alias vim="[ -f Session.vim ] && vim -S || vim"

# prompt
autoload -Uz promptinit
promptinit
prompt neynt

# bindings
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init() {
    echoti smkx
  }
  function zle-line-finish() {
    echoti rmkx
  }
  zle -N zle-line-init
  zle -N zle-line-finish
fi
bindkey -e
bindkey '^r' history-incremental-search-backward
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

# completion
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
autoload -Uz compinit
compinit

setopt histignorealldups
unsetopt share_history

if [[ -f ~/.zshrc.work ]]; then
  source ~/.zshrc.work
fi

# fuzzy finder
source /usr/share/fzf/key-bindings.zsh > /dev/null 2> /dev/null || true
source /usr/share/fzf/completion.zsh > /dev/null 2> /dev/null || true
#source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh || true
