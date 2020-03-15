##== Widgets ==##

autoload -U edit-command-line

foreach widget (
	zle-line-init
	zle-keymap-select
	edit-command-line
	prefix-sudo
	globalias
	cdUndoKey
	cdParentKey
	copybuffer
	exit_zsh
) {
	zle -N $widget
}

# Change the cursor style depending on keymap mode
zle-line-init zle-keymap-select() {
	case $KEYMAP in
		vicmd)      printf '\e[0 q' ;; # Block ("█")
		viins|main) printf '\e[6 q' ;; # Beam  ("|")
	esac
}

# Prefix current command line with `sudo`
prefix-sudo() {
	[[ -z $BUFFER ]] && zle up-history
	if [[ $BUFFER == sudo\ * ]]; then
		LBUFFER="${LBUFFER#sudo }"
	elif [[ $BUFFER == $EDITOR\ * ]]; then
		LBUFFER="${LBUFFER#$EDITOR }"
		LBUFFER="sudoedit $LBUFFER"
	elif [[ $BUFFER == sudoedit\ * ]]; then
		LBUFFER="${LBUFFER#sudoedit }"
		LBUFFER="$EDITOR $LBUFFER"
	else
		LBUFFER="sudo $LBUFFER"
	fi
}

# Expand aliases
globalias() {
	zle _expand_alias
	zle expand-word
	zle self-insert
}

# FileManager-like key bindings
cdUndoKey() { popd; zle reset-prompt; echo; ls; zle reset-prompt ;}
cdParentKey() { pushd ..; zle reset-prompt; echo; ls; zle reset-prompt ;}

# Copy current BUFFER to clipboard
copybuffer() { printf '%s' "$BUFFER" | xclip -selection clipboard ;}

# Exit; even if the command line is full
exit_zsh() { exit }

