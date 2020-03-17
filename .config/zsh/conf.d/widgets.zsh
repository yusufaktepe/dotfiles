##== Widgets ==##

autoload -U edit-command-line

foreach widget (
	zle-line-init
	zle-keymap-select
	edit-command-line
	prefix-sudo
	globalias
	cdPrev
	cdParent
	copybuffer
	exit_zsh
	fzf-history-widget
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
cdPrev() { popd; zle reset-prompt; echo; ls; zle reset-prompt ;}
cdParent() { pushd ..; zle reset-prompt; echo; ls; zle reset-prompt ;}

# Copy current BUFFER to clipboard
copybuffer() { printf '%s' "$BUFFER" | xclip -selection clipboard ;}

# Exit; even if the command line is full
exit_zsh() { exit }

# Select command from history into the command line
fzf-history-widget() {
	(( $+commands[fzf] )) || return 1

	local selected num

	setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2>/dev/null

	selected=( $(fc -rl 1 |
		fzf \
		--nth='2..,..' \
		--tiebreak='index' \
		--query="${LBUFFER}" \
		--exact \
		--no-multi \
		--prompt='$ ')
	)
	local ret=$?

	if [[ -n "$selected" ]]; then
		num=$selected[1]
		[[ -n "$num" ]] && zle vi-fetch-history -n $num
	fi

	zle reset-prompt
	return $ret
}

