##== Functions/Widgets ==##

# Load builtin functions
foreach func (
	# Edit command line in $EDITOR
	edit-command-line
	# Select characters between matching pairs
	select-bracketed
	select-quoted
	# Operate on surroundings
	surround
) {
	autoload -U $func
}
unset func

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
	zcw_cdPrev
	zcw_cdParent
	zcw_copybuffer
	# zcw_exit-zsh
	zcw_globalias
	zcw_fzf-cd
	zcw_fzf-history
	zcw_prefix-sudo
	zcw_toggle-fg
) {
	eval zle -N $widget
}
unset widget

# Change the cursor style depending on keymap mode
zle-line-init zle-keymap-select() {
	case $KEYMAP in
		vicmd)      printf '\e[0 q' ;; # Block ("█")
		viins|main) printf '\e[6 q' ;; # Beam  ("|")
	esac
}

# FileManager-like key bindings
zcw_cdPrev() { popd; zle reset-prompt; echo; ls; zle reset-prompt ;}
zcw_cdParent() { pushd ..; zle reset-prompt; echo; ls; zle reset-prompt ;}

# Copy current BUFFER to clipboard
zcw_copybuffer() { printf '%s' "$BUFFER" | xclip -selection clipboard ;}

# Exit; even if the command line is full
zcw_exit-zsh() { exit }

zcw_fzf-cd() {
	(( $+commands[fzf] )) || return 1

	setopt localoptions pipefail no_aliases 2>/dev/null

	local cmd dir ret
	cmd="command find ~/ /data -mindepth 1 \
		\\( -path '*/\\.git' -o -fstype 'sysfs' -o -fstype 'devfs' \
		-o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune \
		-o -type d -print 2>/dev/null"

	dir=$(eval "$cmd" | fzf +m --preview="tree -L 1 -C {}" \
		--bind=space:toggle-preview --preview-window=:hidden)

	[[ -n "$dir" ]] && cd "$dir"
	ret=$?

	zle reset-prompt
	return $ret
}

# Select command from history into the command line
zcw_fzf-history() {
	(( $+commands[fzf] )) || return 1

	setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2>/dev/null

	local selected ret
	selected=$(fc -rl 1 | fzf -e +m -n2..,.. --tiebreak=index -q "$LBUFFER" --prompt='$ ')
	ret=$?

	[[ -n "$selected" ]] && zle vi-fetch-history -n $selected

	zle reset-prompt
	return $ret
}

# Expand aliases
zcw_globalias() {
	zle _expand_alias
	zle expand-word
	zle self-insert
}

# Prefix current command line with `sudo`
zcw_prefix-sudo() {
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

# Toggle background jobs
zcw_toggle-fg() {
	if [[ $#BUFFER -eq 0 ]]; then
		BUFFER="fg"
		zle accept-line -w
	else
		zle push-input -w
		zle clear-screen -w
	fi
}

bak() { for f in "$@"; { cp "$f" "$(realpath "$f").bak" ;} ;}

# List and load onto directory stack
d() { [[ -n $1 ]] && dirs "$@" || dirs -v | head -10 ;}

# Create directory and cd into it
mkcd() { command mkdir -p "$@" && cd "$_" ;}

# Prevent nested ranger instances
ranger() {
	[[ -z "$RANGER_LEVEL" ]] && command ranger "$@" ||
		echo "Shell is already running inside ranger!"
}

# Prevent nested vifm instances
vifm() {
	[[ -z "$VIFM_SERVER_NAME" ]] && command vifm "$@" ||
		echo "Shell is already running inside vifm!"
}

# Repeat given command with ${T:-3} interval
rpeat() { n=$1; shift; while [[ $(( n -= 1 )) -ge 0 ]]; do "$@"; sleep ${T:-3}; done ;}

tyco() { [ -n "$1" ] && find . -type f -name "*.$1" | wc -l ;}
tyrm() { [ -n "$1" ] && find . -type f -name "*.$1" -exec trash-put {} \; ;}

enc() { for f in "$@"; do gpg -e "$f"; done ;}

