#!/bin/sh

# XDG User Dirs
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_BIN_HOME="$HOME/.local/bin"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_LIB_HOME="$HOME/.local/lib"

# Defaults
export EDITOR="nvim"
export VISUAL="$EDITOR"
export TERMINAL="alacritty"
export TERMINS="$TERMINAL --class"
export TERMCMD="$TERMINAL"
export BROWSER="vivaldi-stable"
export FM="vifm-tab"

# Keep $HOME clean
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"

export LESSHISTFILE="$XDG_CACHE_HOME/lesshst"
export PYLINTHOME="$XDG_CACHE_HOME/pylint"

export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
export INPUTRC="$XDG_CONFIG_HOME/bash/inputrc"
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
export PATH="$PATH:$GOPATH/bin:$(find "$HOME/.local/bin/" -name '.*' -prune -o -type d -print | paste -sd:)"

# Others
export SUDO_ASKPASS="$XDG_BIN_HOME/menus/rofi-askpass"
export FZF_DEFAULT_OPTS="
	--layout=reverse --height 50%
	--bind '?:toggle-preview,alt-k:preview-up,alt-p:preview-page-up'
	--bind 'alt-j:preview-down,alt-n:preview-page-down'
	--bind 'alt-w:toggle-preview-wrap'
	"
export RANGER_LOAD_DEFAULT_RC="false"
export QT_QPA_PLATFORMTHEME="qt5ct"

# Less Colors
export LESS=-R
export LESS_TERMCAP_mb=$(printf "\e[1;31m")
export LESS_TERMCAP_md=$(printf "\e[1;31m")
export LESS_TERMCAP_me=$(printf "\e[0m")
export LESS_TERMCAP_se=$(printf "\e[0m")
export LESS_TERMCAP_so=$(printf "\e[1;44;33m")
export LESS_TERMCAP_ue=$(printf "\e[0m")
export LESS_TERMCAP_us=$(printf "\e[1;32m")
export LESSOPEN="| highlight -O xterm256 -s pablo %s 2>/dev/null"

# Switch escape and caps if tty (add to sudoers NOPASSWD)
sudo -n loadkeys ~/.config/ttymaps.kmap 2>/dev/null

# GPG - refresh on tty changes
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null

# If login shell is bash, source bashrc
[ -n "$BASH_VERSION" ] && [ -f "$BDOTDIR/.bashrc" ] && . "$BDOTDIR/.bashrc"

# Source secrets
[ -f "$XDG_CONFIG_HOME/secrets.env" ] && . "$XDG_CONFIG_HOME/secrets.env"

# StartX on tty1 login
[ -z "$DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ] &&
	exec startx "$XINITRC" -- -quiet > "$XDG_DATA_HOME/xorg/Xorg.log" 2>&1

