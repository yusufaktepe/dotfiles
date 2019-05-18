#!/bin/bash
#
# ~/.bashrc
#

[[ $- != *i* ]] && return
[[ $DISPLAY ]] && shopt -s checkwinsize

PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"

HISTSIZE= HISTFILESIZE= # Infinite history.
stty -ixon # Disable ctrl-s and ctrl-q.

complete -cf sudo
shopt -s autocd
shopt -s expand_aliases
shopt -s histappend

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Source my aliases:
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"
