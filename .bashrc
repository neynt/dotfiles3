# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
eval `dircolors -b ~/.dir_colors`
alias ls='ls --color=auto'

if [[ -f ~/.bashrc.local ]]; then
  source ~/.bashrc.local
fi
