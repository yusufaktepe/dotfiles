##== Keys ==##

bindkey -v

# The time the shell waits (ms) for another key to be pressed
KEYTIMEOUT=10

# Create a zkbd compatible hash
# to add other keys to this hash, see: man 5 terminfo
# to find keycodes, run 'showkey -a' OR Ctrl+V+keypress
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backs]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PgUp]="${terminfo[kpp]}"
key[PgDown]="${terminfo[knp]}"
key[ShiftTab]="${terminfo[kcbt]}"
key[C-Backs]="${terminfo[cub1]}"
key[C-Left]="${terminfo[kLFT5]}"
key[C-Right]="${terminfo[kRIT5]}"

# Setup keys accordingly
[[ -n "${key[Home]}"     ]] && bindkey -- "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]] && bindkey -- "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]] && bindkey -- "${key[Insert]}"   overwrite-mode
[[ -n "${key[Backs]}"    ]] && bindkey -- "${key[Backs]}"    backward-delete-char
[[ -n "${key[Delete]}"   ]] && bindkey -- "${key[Delete]}"   delete-char
[[ -n "${key[Up]}"       ]] && bindkey -- "${key[Up]}"       history-substring-search-up
[[ -n "${key[Down]}"     ]] && bindkey -- "${key[Down]}"     history-substring-search-down
[[ -n "${key[Left]}"     ]] && bindkey -- "${key[Left]}"     backward-char
[[ -n "${key[Right]}"    ]] && bindkey -- "${key[Right]}"    forward-char
[[ -n "${key[PgUp]}"     ]] && bindkey -- "${key[PgUp]}"     history-beginning-search-backward
[[ -n "${key[PgDown]}"   ]] && bindkey -- "${key[PgDown]}"   history-beginning-search-forward
[[ -n "${key[ShiftTab]}" ]] && bindkey -- "${key[ShiftTab]}" reverse-menu-complete
[[ -n "${key[C-Left]}"   ]] && bindkey -- "${key[C-Left]}"   backward-word
[[ -n "${key[C-Right]}"  ]] && bindkey -- "${key[C-Right]}"  forward-word
[[ -n "${key[C-Backs]}"  ]] && bindkey -- "${key[C-Backs]}"  backward-kill-word

[[ -n "${key[Home]}"   ]] && bindkey -M vicmd "${key[Home]}"   beginning-of-line
[[ -n "${key[End]}"    ]] && bindkey -M vicmd "${key[End]}"    end-of-line
[[ -n "${key[Insert]}" ]] && bindkey -M vicmd "${key[Insert]}" vi-insert
[[ -n "${key[Delete]}" ]] && bindkey -M vicmd "${key[Delete]}" delete-char
[[ -n "${key[PgUp]}"   ]] && bindkey -M vicmd "${key[PgUp]}"   history-beginning-search-backward
[[ -n "${key[PgDown]}" ]] && bindkey -M vicmd "${key[PgDown]}" history-beginning-search-forward
[[ -n "${key[StHome]}" ]] && bindkey -M vicmd "${key[StHome]}" beginning-of-line
[[ -n "${key[StIns]}"  ]] && bindkey -M vicmd "${key[StIns]}"  vi-insert
[[ -n "${key[StDel]}"  ]] && bindkey -M vicmd "${key[StDel]}"  delete-char

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	zle_application_mode_start() { echoti smkx }
	zle_application_mode_stop() { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

bindkey ' ' magic-space # [Space] - do history expansion

bindkey '^[[1;5C' forward-word    # st:[Ctrl-Right] - move forward one word
bindkey '^[[1;5D' backward-word   # st:[Ctrl-Left] - move backward one word

bindkey '^[[3;5~' kill-word # [Ctrl-Delete]

bindkey '^P' history-substring-search-up   # [Ctrl-p]
bindkey '^N' history-substring-search-down # [Ctrl-n]

bindkey -M vicmd 'k' history-substring-search-up   # [VIN|k]
bindkey -M vicmd 'j' history-substring-search-down # [VIN|j]

bindkey -M vicmd 'H' vi-beginning-of-line  # [VIN|H] - move cursor to beginning of line
bindkey -M vicmd 'L' vi-end-of-line        # [VIN|L] - move cursor to end of line
bindkey -M visual 'H' vi-beginning-of-line # [VIS|H]
bindkey -M visual 'L' vi-end-of-line       # [VIS|L]
bindkey -M viopp 'H' vi-beginning-of-line  # [VIO|H]
bindkey -M viopp 'L' vi-end-of-line        # [VIO|L]

#== Completion Mode (requires `complist` module)
bindkey -M menuselect '^?' undo                 # [Backspace] - undo inserted match
bindkey -M menuselect '+' accept-and-hold       # [+] - accept the selection but keep the completion list open
bindkey -M menuselect '^J' down-line-or-history # [Ctrl-j] - navigate down completion
bindkey -M menuselect '^K' up-line-or-history   # [Ctrl-k] - navigate up completion
bindkey -M menuselect '^H' backward-char        # [Ctrl-h] - navigate left completion
bindkey -M menuselect '^L' forward-char         # [Ctrl-l] - navigate right completion

#== Function/Widget bindings
bindkey '^E' edit-command-line          # [Ctrl-e] - edit command line with $EDITOR
bindkey "^[s" zcw_prefix-sudo           # [Alt-s] to add sudo prefix
bindkey "^[ " zcw_globalias             # [Alt-Space] to expand alias
bindkey '^[[1;3D' zcw_cdPrev            # [Alt-Left] - go back in directory history
bindkey '^[[1;3A' zcw_cdParent          # [Alt-Up] - go to the parent directory
bindkey '^Y' zcw_copybuffer             # [Ctrl-y] - copy current BUFFER to clipboard
# bindkey '^D' zcw_exit-zsh             # [Ctrl-d] - exit; even if the command line is full
bindkey '^Z' zcw_toggle-fg              # [Ctrl-z] - toggle background jobs
bindkey '\ec' zcw_fzf-cd                # [Alt-c]  - cd into the selected directory
bindkey '^R' zcw_fzf-history            # [Ctrl-r] - select command from history into the command line
bindkey -M vicmd '^E' edit-command-line # [VIN|Ctrl-e] - edit command line with $EDITOR
bindkey -M vicmd '^[s' zcw_prefix-sudo  # [VIN|Alt-s] to add sudo prefix
bindkey -M vicmd "^[ " zcw_globalias    # [VIN|Alt-Space] to expand alias
# bindkey -M vicmd '^D' zcw_exit-zsh    # [VIN|Ctrl-d] - exit; even if the command line is full

# Operate on surroundings
bindkey -M vicmd 'cs' change-surround   # [VIN|cs?] - change surroundings
bindkey -M vicmd 'ds' delete-surround   # [VIN|ds?] - delete surroundings
bindkey -M vicmd 'ys' add-surround      # [VIN|ys?] - add surroundings
bindkey -M visual 'S' add-surround      # [VIS|S] - add surroundings

# Select characters between matching pairs: [ca?] & [ci?]
foreach c ({a,i}${(s..)^:-'()[]{}<>bB'}) {
	bindkey -M visual $c select-bracketed
	bindkey -M viopp $c select-bracketed
}
foreach c ({a,i}{\',\",\`}) {
	bindkey -M visual $c select-quoted
	bindkey -M viopp $c select-quoted
}

#== Alias bindings
bindkey -s '^[h' 'vH\n'
bindkey -s '^f' 'f\n'
bindkey -s '^o' 'fcd\n'
bindkey -s '^[f' 'vifm-tab\n'

