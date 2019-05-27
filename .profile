#!/bin/sh
#
# ~/.profile
#

# Adds `~/.local/bin` and all subdirectories to $PATH
export PATH="$PATH:$(find "$HOME/.local/bin/" -type d | tr '\n' ':' | sed 's/:*$//')"

export XDG_CONFIG_HOME="$HOME/.config"

# Defaults:
export EDITOR="nvim"
export VISUAL="$EDITOR"
export TERMINAL="st"
export BROWSER="vivaldi-stable"
export READER="zathura"
export FILE="vu"

# Keep $HOME clean:
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
export INPUTRC="$HOME/.config/inputrc"
export LESSHISTFILE="$HOME/.cache/lesshst"
export NOTMUCH_CONFIG="$HOME/.config/notmuch.conf"
export PASSWORD_STORE_DIR="$HOME/.local/share/password-store"

# Others:
export SUDO_ASKPASS="$HOME/.local/bin/dmenu-rofi/rofi-askpass"
export FZF_DEFAULT_OPTS="--layout=reverse --height 50%"
export QT_QPA_PLATFORMTHEME="qt5ct"

# Start i3 on tty1 login
[ -z "$DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ] && exec startx -- -quiet > ~/.cache/Xorg.log 2>&1

# Switch escape and caps if tty (add to sudoers NOPASSWD):
sudo -n loadkeys ~/.config/ttymaps.kmap 2>/dev/null

# Required for using ssh with gpg agent:
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null

# If shell is bash, source .bashrc
[ -n "$BASH_VERSION" ] && [ -f ~/.bashrc ] && source "$HOME/.bashrc"
