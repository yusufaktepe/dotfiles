#!/bin/bash
#
# ~/.bashrc
#

[[ $- != *i* ]] && return
[[ $DISPLAY ]] && shopt -s checkwinsize

PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"

HISTFILE=$BDOTDIR/.bash_history
HISTSIZE= HISTFILESIZE= # Infinite history.
HISTCONTROL=ignoreboth

stty -ixon # Disable ctrl-s and ctrl-q.

complete -cf sudo
shopt -s autocd
shopt -s expand_aliases
shopt -s histappend

# pkgfile "command not found" hook:
. /usr/share/doc/pkgfile/command-not-found.bash

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Source my aliases:
[ -f "$HOME/.config/shell/aliasrc" ] && source "$HOME/.config/shell/aliasrc"
