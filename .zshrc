# Zsh config by Yusuf Aktepe <yusuf@yusufaktepe.com>
# https://github.com/yusufaktepe/dotfiles

#=====================================================================
# Options
#=====================================================================

setopt APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_VERIFY
setopt SHARE_HISTORY
setopt INTERACTIVE_COMMENTS
setopt EXTENDED_GLOB
unsetopt CASE_GLOB
setopt NUMERIC_GLOB_SORT
setopt RC_EXPAND_PARAM
setopt CORRECT_ALL
setopt PROMPT_SUBST
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_MINUS
#setopt COMPLETE_ALIASES
setopt GLOB_COMPLETE
unsetopt MENU_COMPLETE
unsetopt FLOW_CONTROL
setopt AUTO_MENU
setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END

#==================================

HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=10000

#=====================================================================
# Completion
#=====================================================================

#zmodload -i zsh/complist zsh/computil
autoload -U compinit colors zmv && colors	# zcalc
compinit -d ~/.cache/zcompdump-${HOST}-${ZSH_VERSION}

# Enable ls colors
export LSCOLORS="Gxfxcxdxbxegedabagacad"
[[ -z "$LS_COLORS" ]] && (( $+commands[dircolors] )) && eval "$(dircolors -b)"
ls --color -d . &>/dev/null && alias ls='ls --color=tty' || { ls -G . &>/dev/null && alias ls='ls -G' }

zstyle ':completion:*:default' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' rehash true		# automatically find new executables in path
zstyle ':completion:*' special-dirs true	# Complete . and .. special directories
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path ~/.cache
zstyle ':completion:*:*:*:*:processes' command 'ps -u $USER -o pid,user,comm -w -w'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

# Don't complete uninteresting users
zstyle ':completion:*:*:*:users' ignored-patterns \
	adm amanda apache at avahi avahi-autoipd beaglidx bin cacti canna \
	clamav daemon dbus distcache dnsmasq dovecot fax ftp games gdm \
	gkrellmd gopher hacluster haldaemon halt hsqldb ident junkbust kdm \
	ldap lp mail mailman mailnull man messagebus  mldonkey mysql nagios \
	named netdump news nfsnobody nobody nscd ntp nut nx obsrun openvpn \
	operator pcap polkitd postfix postgres privoxy pulse pvm quagga radvd \
	rpc rpcuser rpm rtkit scard shutdown squid sshd statd svn sync tftp \
	usbmux uucp vcsa wwwrun xfs '_*'

zstyle '*' single-ignored show

WORDCHARS=${WORDCHARS//\/[&.;]}

#=====================================================================
# Prompt
#=====================================================================

PROMPT="%B%{$fg[cyan]%}%(4~|%-1~/.../%2~|%~)%u%b >%{$fg[cyan]%}>%B%(?.%{$fg[cyan]%}.%{$fg[red]%})>%{$reset_color%}%b "

#=====================================================================
# Colored man pages
#=====================================================================

export LESS=-R
export LESS_TERMCAP_mb=$(printf "\e[1;31m")
export LESS_TERMCAP_md=$(printf "\e[1;31m")
export LESS_TERMCAP_me=$(printf "\e[0m")
export LESS_TERMCAP_se=$(printf "\e[0m")
export LESS_TERMCAP_so=$(printf "\e[1;44;33m")
export LESS_TERMCAP_ue=$(printf "\e[0m")
export LESS_TERMCAP_us=$(printf "\e[1;32m")

#=====================================================================
# Plugins
#=====================================================================

# Use autosuggestion
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
# Load zsh-syntax-highlighting before history-substring-search.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Use history substring search
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
# pkgfile "command not found" hook:
source /usr/share/doc/pkgfile/command-not-found.zsh

# Load alias for thefuck:
eval $(thefuck --alias)

# Use history-substring-search instead
#autoload -U up-line-or-beginning-search
#autoload -U down-line-or-beginning-search
#zle -N up-line-or-beginning-search
#zle -N down-line-or-beginning-search

#=====================================================================
# Keys
#=====================================================================
# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
# to find keycodes, run 'showkey -a'
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[ShiftTab]="${terminfo[kcbt]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"	beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"	end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"	overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}"	backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"	delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"		history-substring-search-up
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"	history-substring-search-down
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"	backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"	forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"	history-beginning-search-backward
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"	history-beginning-search-forward
[[ -n "${key[ShiftTab]}"  ]] && bindkey -- "${key[ShiftTab]}"	reverse-menu-complete

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start () { echoti smkx }
	function zle_application_mode_stop () { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

bindkey	"^[[H"	beginning-of-line	# [Home]
bindkey	"^[[4~"	end-of-line		# [End]

bindkey '^H' backward-kill-word		# [ctrl+backspace] delete previous word with
bindkey '^[[Z' reverse-menu-complete	# [Shift+tab]

bindkey '\ew' kill-region		# [Esc-w] - Kill from the cursor to the mark
bindkey -s '\el' 'ls\n'			# [Esc-l] - run command: ls
bindkey ' ' magic-space			# [Space] - do history expansion

bindkey '^[[1;5C' forward-word		# [Ctrl-RightArrow] - move forward one word
bindkey '^[[1;5D' backward-word		# [Ctrl-LeftArrow] - move backward one word

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down

autoload -U edit-command-line && zle -N edit-command-line
bindkey '^Xe' edit-command-line		# hit 'Ctrl+X e' to edit with $EDITOR
bindkey -M vicmd v edit-command-line	# hit 'v' in normal mode to edit with $EDITOR

# Previous Command Hotkeys Alt+1, Alt+2 ...etc
bindkey -s '\e1' "!:0 \t"		# last command
bindkey -s '\e2' "!:0-1 \t"		# last command + 1st argument
bindkey -s '\e3' "!:0-2 \t"		# last command + 1st-2nd argument
bindkey -s '\e4' "!:0-3 \t"		# last command + 1st-3rd argument
bindkey -s '\e5' "!:0-4 \t"		# last command + 1st-4th argument
bindkey -s '\e"' "!:0- \t"		# all but the last argument
bindkey -s '\e9' "!:0 !:2* \t"		# all but the 1st argument (aka 2nd word)

#=====================================================================
# Vim Mode
#=====================================================================

bindkey -v
KEYTIMEOUT=1

# Default cursor shape (insert mode)
zle-line-init() { echo -ne "\e[5 q" ;}

# Updates editor information when the keymap changes.
function zle-keymap-select() {
	[ $KEYMAP = vicmd ] && echo -ne "\e[2 q" || echo -ne "\e[5 q"
	zle reset-prompt
	zle -R
}

zle -N zle-line-init
zle -N zle-keymap-select

#=====================================================================
# Functions
#=====================================================================

sudo-command-line() {
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
zle -N sudo-command-line
#bindkey "\e\e" sudo-command-line
bindkey "^f" sudo-command-line # [Alt+f] to add sudo prefix

globalias() {
	zle _expand_alias
	zle expand-word
	zle self-insert
}
zle -N globalias
bindkey "^[ " globalias	# [Alt+Space] to expand alias

# [ <command> | clipcopy ] - [ clipcopy <file> ]
function clipcopy() {
	emulate -L zsh
	local file=$1
	if (( $+commands[xclip] )); then
		if [[ -z $file ]]; then
			xclip -in -selection clipboard
		else
			xclip -in -selection clipboard $file
		fi
	elif (( $+commands[xsel] )); then
		if [[ -z $file ]]; then
			xsel --clipboard --input
		else
			cat "$file" | xsel --clipboard --input
		fi
	else
		print "clipcopy: xclip/xsel not installed" >&2
		return 1
	fi
}

# [ clippaste | <command> ] - [ clippaste > <file> ] - [ clippaste | grep foo ]
function clippaste() {
	emulate -L zsh
	if (( $+commands[xclip] )); then
		xclip -out -selection clipboard
	elif (( $+commands[xsel] )); then
		xsel --clipboard --output
	else
		print "clipcopy: xclip/xsel not installed" >&2
		return 1
	fi
}

function copydir {
	emulate -L zsh
	print -n $PWD | clipcopy
}

function copyfile {
	emulate -L zsh
	clipcopy $1
}

# cpv function that uses rsync
cpv() { rsync -pogbr -hhh --backup-dir=/tmp/rsync -e /dev/null --progress "$@" ;}
compdef _files cpv

alias h='history'
hs() { history | grep $* ;}
alias hsi='hs -i'

cdUndoKey() {
	popd
	zle reset-prompt
	echo
	ls
	zle reset-prompt
}
zle -N cdUndoKey
bindkey '^[[1;3D' cdUndoKey # [Alt+Left] - go back in directory history

# fzf_history() { zle -I; eval $(history | fzf +s | sed 's/ *[0-9]* *//') ;}; zle -N fzf_history; bindkey '^H' fzf_history
# fzf_killps() { zle -I; ps -ef | sed 1d | fzf -m | awk '{print $2}' | xargs kill -${1:-9} ;}; zle -N fzf_killps; bindkey '^Q' fzf_killps
# fzf_cd() { zle -I; DIR=$(find ${1:-*} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf) && cd "$DIR" ;}; zle -N fzf_cd; bindkey '^E' fzf_cd
zle -N copyx; copyx() { echo -E $BUFFER | xsel -ib }; bindkey '^Y' copyx

#=====================================================================
# Set Terminal Title
#=====================================================================

function title {
	emulate -L zsh

	: ${2=$1} # if $2 is unset use $1; if it is set and empty, leave it as is

	case "$TERM" in
		xterm*|rxvt*|ansi)
			print -Pn "\e]2;$2:q\a"	# set window name
			print -Pn "\e]1;$1:q\a"	# set tab name
		;;
		screen*|tmux*)
			print -Pn "\ek$1:q\e\\"	# set screen hardstatus
		;;
		*)
			# Try to use terminfo to set the title
			if [[ -n "$terminfo[fsl]" ]] && [[ -n "$terminfo[tsl]" ]]; then
				echoti tsl
				print -Pn "$1"
				echoti fsl
			fi
		;;
	esac
}

ZSH_THEME_TERM_TAB_TITLE_IDLE="%15<..<%~%<<"	#15 char left truncated PWD
ZSH_THEME_TERM_TITLE_IDLE="%n@%m: %~"

# Runs before showing the prompt
function termsupport_precmd {
	emulate -L zsh
	title $ZSH_THEME_TERM_TAB_TITLE_IDLE $ZSH_THEME_TERM_TITLE_IDLE
}

# Runs before executing the command
function termsupport_preexec {
	emulate -L zsh
	# cmd name only, or if this is sudo or ssh, the next cmd
	local CMD=${1[(wr)^(*=*|sudo|ssh|mosh|rake|-*)]:gs/%/%%}
	local LINE="${2:gs/%/%%}"
	title '$CMD' '%100>...>$LINE%<<'
}

precmd_functions+=(termsupport_precmd)
preexec_functions+=(termsupport_preexec)

#=====================================================================
# Aliases
#=====================================================================

# No correct
alias cp='nocorrect cp'
alias ebuild='nocorrect ebuild'
alias gist='nocorrect gist'
alias heroku='nocorrect heroku'
alias hpodder='nocorrect hpodder'
alias man='nocorrect man'
alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv'
alias mysql='nocorrect mysql'
alias sudo='nocorrect sudo'

# Dir stack
alias d='dirs -v | head -10'
alias -- -='cd -'
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

alias -g L='| less'
alias -g C='| wc -l'
alias -g H='| head'
alias -g HL='| head -n $(( +LINES ? LINES - 4 : 20 ))'
alias -g T='| tail'
alias -g TL='| tail -n $(( +LINES ? LINES - 4 : 20 ))'
alias -g G='| grep'
alias -g TRIM='| cut -c 1-$COLUMNS'
alias -g C='| wc -l'
alias -g Ss='| sort'
alias -g Su='| sort -u'
alias -g Sn='| sort -n'
alias -g Snr='| sort -nr'

alias -g NUL="> /dev/null 2>&1"
alias -g N="&>/dev/null"
alias -g N1="1>/dev/null"
alias -g N2="2>/dev/null"

[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"