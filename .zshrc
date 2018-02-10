# additional functions (mainly my prompt)
fpath=( "$HOME/.zsh" $fpath )

# language support
export GOPATH=~/go
export PATH="$PATH:$GOPATH/bin"
type ruby > /dev/null && export PATH=$(ruby -rrubygems -e "puts Gem.user_dir")/bin:$PATH
export PATH=~/.npm-global/bin:$PATH
export PATH=~/bin:$PATH
export ANDROID_HOME=/opt/android-sdk
export EDITOR=vim
export BROWSER=chromium
source ~/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# fuzzy finder
source /usr/share/fzf/key-bindings.zsh > /dev/null 2> /dev/null || true
source /usr/share/fzf/completion.zsh > /dev/null 2> /dev/null || true

HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

# aliases
alias ls="ls -F --color=auto"
alias grep="grep --color=auto"
alias tmux="tmux -2"
alias diff="colordiff"
alias ..="cd .."
alias ...="cd ../.."
function ssht() { ssh -t $@ "tmux attach || tmux new" }
function sshty() { ssht -Y $@ }
function sshcs() { ssht z394zhan@ubuntu1604-002.student.cs.uwaterloo.ca }
function sshcsy() { ssht -Y z394zhan@ubuntu1604-002.student.cs.uwaterloo.ca }
function mypandoc() { pandoc -V geometry:margin=1in $@ }

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
bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}"  end-of-line
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

eval `dircolors -b ~/.dir_colors`

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

setopt histignorealldups sharehistory

if [[ -f ~/.zshrc.work ]]; then
  source ~/.zshrc.work
fi
