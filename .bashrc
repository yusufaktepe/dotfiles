#
# ~/.bashrc
#

PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

HISTSIZE= HISTFILESIZE= # Infinite history.
stty -ixon # Disable ctrl-s and ctrl-q.

complete -cf sudo
shopt -s autocd
shopt -s expand_aliases
shopt -s histappend
shopt -s checkwinsize

# Source my aliases:
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"
