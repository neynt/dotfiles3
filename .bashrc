# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [[ -f ~/.bashrc.local ]]; then
  source ~/.bashrc.local
fi

if [[ -f ~/.sharedrc ]]; then
  source ~/.sharedrc
fi

PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
