# additional functions (mainly my prompt)
fpath=( "$HOME/.zsh" $fpath )

# env vars
export PATH="$PATH:$GOPATH/bin"
type ruby > /dev/null && export PATH=$(ruby -rrubygems -e "puts Gem.user_dir")/bin:$PATH
[ -d ~/.npm-global/bin ] && export PATH=~/.npm-global/bin:$PATH
[ -d ~/.cargo/bin ] && export PATH=~/.cargo/bin:$PATH
[ -d ~/bin ] && export PATH=~/bin:$PATH
[ -d ~/go ] && export GOPATH=~/go
if [ -d /trove/apps/android-sdk ]; then
  export ANDROID_HOME=/trove/apps/android-sdk
  export ANDROID_SDK_ROOT=$ANDROID_HOME
  export ANDROID_NDK_ROOT=$ANDROID_HOME/ndk-bundle
  export PATH=$ANDROID_SDK_ROOT/tools:$PATH
  export PATH=$ANDROID_NDK_ROOT:$PATH
fi
export EDITOR=nvim
export BROWSER=firefox
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
type nvim > /dev/null && alias vim=nvim && alias oldvim=vim # sorry bram :<
alias ..="cd .."
alias ...="cd ../.."
function ssht() { ssh -t $@ "tmux attach || tmux new" }
function sshcs() { ssht $@ z394zhan@ubuntu1604-002.student.cs.uwaterloo.ca }
function sshece() { ssh -A $@ z394zhan@ecelinux4.uwaterloo.ca }
function sshece1() { ssh -A $@ z394zhan@ecelinux4.uwaterloo.ca -t "ssh -A ecelinux1 -t \"tmux attach || tmux new\"" }
function sshazure() { ssh -A $@ -i ~/.ssh/student_z394zhan z394zhan@ECE454S18-ssh.azurehdinsight.net }
function mypandoc() { pandoc -V geometry:margin=1in $@ }
function mypython() { mypy --strict $@ && python $@ }
function venv() { source venv/bin/activate }

function run_cpp() {
  executable="${1%.cpp}"
  g++ -o $executable $1 && ./$executable
}

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
