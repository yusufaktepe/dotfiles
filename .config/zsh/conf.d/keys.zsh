##== Keys ==##

bindkey -v
KEYTIMEOUT=1

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

bindkey '^P' history-substring-search-up   # [Ctrl-p]
bindkey '^N' history-substring-search-down # [Ctrl-n]

bindkey -M vicmd 'k' history-substring-search-up   # [VI|k]
bindkey -M vicmd 'j' history-substring-search-down # [VI|j]

bindkey -M vicmd 'H' vi-beginning-of-line # [VI|Shift-h] - move cursor to beginning of line
bindkey -M vicmd 'L' vi-end-of-line       # [VI|Shift-l] - move cursor to end of line

#== Completion Mode (requires `complist` module)
bindkey -M menuselect '^?' undo                 # [Backspace] - undo inserted match
bindkey -M menuselect '+' accept-and-hold       # [+] - accept the selection but keep the completion list open
bindkey -M menuselect '^J' down-line-or-history # [Ctrl-j] - navigate down completion
bindkey -M menuselect '^K' up-line-or-history   # [Ctrl-k] - navigate up completion
bindkey -M menuselect '^H' backward-char        # [Ctrl-h] - navigate left completion
bindkey -M menuselect '^L' forward-char         # [Ctrl-l] - navigate right completion

#== Widget bindings
bindkey '^Xe' edit-command-line         # [Ctrl-x+e] - edit command line with $EDITOR
bindkey "^f" prefix-sudo                # [Ctrl-f] to add sudo prefix
bindkey "^[ " globalias                 # [Alt-Space] to expand alias
bindkey '^[[1;3D' cdUndoKey             # [Alt-Left] - go back in directory history
bindkey '^[[1;3A' cdParentKey           # [Alt-Up] - go to the parent directory
bindkey '^Y' copybuffer                 # [Ctrl-y] - copy current BUFFER to clipboard
bindkey '^D' exit_zsh                   # [Ctrl-d] - exit; even if the command line is full
bindkey '^R' fzf-history-widget         # [Ctrl-r] - select command from history into the command line
# bindkey -M vicmd v edit-command-line  # [VI|v] - edit command line with $EDITOR
bindkey -M vicmd '^f' prefix-sudo       # [VI|Ctrl-f] to add sudo prefix
bindkey -M vicmd "^[ " globalias        # [VI|Alt-Space] to expand alias
bindkey -M vicmd '^D' exit_zsh          # [VI|Ctrl-d] - exit; even if the command line is full

#== Alias bindings
bindkey -s '^[h' 'vH\n'
bindkey -s '^o' 'rcd\n'

