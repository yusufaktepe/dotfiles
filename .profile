#!/bin/sh

# XDG User Dirs
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_BIN_HOME="$HOME/.local/bin"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_LIB_HOME="$HOME/.local/lib"

# Defaults:
export EDITOR="nvim"
export VISUAL="$EDITOR"
export TERMINAL="st"
export TERMINAL_N="st -n"
export BROWSER="vivaldi-stable"
export READER="zathura"
export FILE="lf"

# Keep $HOME clean:
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"

export LESSHISTFILE="$XDG_CACHE_HOME/lesshst"

export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
export INPUTRC="$XDG_CONFIG_HOME/shell/inputrc"
export NOTMUCH_CONFIG="$XDG_CONFIG_HOME/notmuch.conf"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npmrc"
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"

export CARGO_HOME="$XDG_LIB_HOME/cargo"
export GOPATH="$XDG_LIB_HOME/go"
export RUSTUP_HOME="$XDG_LIB_HOME/rustup"

export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export TERMINFO="$XDG_DATA_HOME/terminfo"
export TERMINFO_DIRS="$XDG_DATA_HOME/terminfo:/usr/share/terminfo"

# Adds `~/.local/bin` and all subdirectories to $PATH
export PATH="$PATH:$GOPATH/bin:$(find "$HOME/.local/bin/" -type d | tr '\n' ':' | sed 's/:*$//')"

# Others:
export SUDO_ASKPASS="$XDG_BIN_HOME/dmenu-rofi/rofi-askpass"
export FZF_DEFAULT_OPTS="--layout=reverse --height 50%"
export QT_QPA_PLATFORMTHEME="qt5ct"

# Start i3 on tty1 login
if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
	exec startx "$XINITRC" -- -quiet > ~/.cache/Xorg.log 2>&1
fi

# Switch escape and caps if tty (add to sudoers NOPASSWD):
sudo -n loadkeys ~/.config/ttymaps.kmap 2>/dev/null

# Required for using ssh with gpg agent:
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null

# If login shell is bash, source bashrc
[ -n "$BASH_VERSION" ] && [ -f "$BDOTDIR/.bashrc" ] && . "$BDOTDIR/.bashrc"
