if [[ -f ~/.bashrc.local ]]; then
  source ~/.bashrc.local
fi

if [[ -f ~/.sharedrc ]]; then
  source ~/.sharedrc
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n\$ '

export HISTSIZE=
export HISTFILESIZE=
export HISTFILE=~/.bash_eternal_history

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
