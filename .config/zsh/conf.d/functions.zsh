##== Functions/Widgets ==##

# Load builtin functions
foreach function (
	# Edit command line in $EDITOR
	edit-command-line
	# Select characters between matching pairs
	select-bracketed
	select-quoted
	# Operate on surroundings
	surround
) {
	autoload -U $function
}

# Register functions as widgets
foreach widget (
	#= Builtin
	# Executed  every time the zle is started to read a new line of input
	zle-line-init
	# Executed every time the keymap changes
	zle-keymap-select
	edit-command-line
	select-bracketed
	select-quoted
	'add-surround surround'
	'change-surround surround'
	'delete-surround surround'

	#= Custom
	cdPrev
	cdParent
	copybuffer
	# exit_zsh
	globalias
	fzf-history-widget
	prefix-sudo
) {
	eval zle -N $widget
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

# List and load onto directory stack
d() { [[ -n $1 ]] && dirs "$@" || dirs -v | head -10 ;}

# Create directory and cd into it
mkcd() { command mkdir -p "$@" && cd "$_" ;}

# Prevent nested ranger instances
ranger() {
	[[ -z "$RANGER_LEVEL" ]] && command ranger "$@" || \
		echo "Shell is already running inside ranger!"
}

# Repeat given command with ${T:-3} interval
rpeat() { n=$1; shift; while [[ $(( n -= 1 )) -ge 0 ]]; do "$@"; sleep ${T:-3}; done ;}

