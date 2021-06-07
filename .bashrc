if [[ -f ~/.bashrc.local ]]; then
  source ~/.bashrc.local
fi

if [[ -f ~/.sharedrc ]]; then
  source ~/.sharedrc
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n\$ '

# Adding the kdesrc-build directory to the path
export PATH="$HOME/kde/src/kdesrc-build:$PATH"

export HISTSIZE=
export HISTFILESIZE=
export HISTFILE=~/.bash_eternal_history

# Creating alias for running software built with kdesrc-build
kdesrc-run ()
{
  source "$HOME/kde/build/$1/prefix.sh" && "$HOME/kde/usr/bin/$1"
}

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
