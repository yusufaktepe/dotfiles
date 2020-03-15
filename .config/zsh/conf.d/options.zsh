##== Options ==##

# Changing Directories
DIRSTACKSIZE=9                # The maximum size of the directory stack for `pushd` and `popd`.
setopt AUTO_CD                # Automatically cd into directories.
setopt AUTO_PUSHD             # Make cd push the old directory onto the directory stack.
setopt PUSHD_IGNORE_DUPS      # Don't push multiple copies of the same directory onto the directory stack.
setopt PUSHD_MINUS            # Exchanges the meanings of `+' and `-' for pushd.
setopt PUSHD_SILENT           # Do not print the directory stack after pushd or popd.

# Completion
unsetopt MENU_COMPLETE        # Do not autoselect the first completion entry.
setopt AUTO_MENU              # Automatically use menu completion after the second consecutive request for completion.
setopt COMPLETE_IN_WORD       # Complete from both ends.
setopt ALWAYS_TO_END          # After in-word completion, move cursor to end of the word.

# Expansion and Globbing
setopt EXTENDED_GLOB          # Treat the `#`, `~` and `^` characters as part of patterns for globbing.
setopt NUMERIC_GLOB_SORT      # Sort the filenames numerically rather than lexicographically.
setopt RC_EXPAND_PARAM        # Expand arrays.

# History
HISTFILE="$ZDOTDIR/.zsh_history"
HISTSIZE=100000               # The maximum number of events stored in the internal history list.
SAVEHIST=$HISTSIZE            # The maximum number of history events to save in the history file.
setopt INC_APPEND_HISTORY     # Immediately write to the history, don't wait shell to exit.
setopt EXTENDED_HISTORY       # Save each command's epoch timestamps and the duration in seconds.
setopt HIST_FIND_NO_DUPS      # Do not display duplicates of a line previously found.
setopt HIST_IGNORE_ALL_DUPS   # Remove duplicated older entry from history.
setopt HIST_IGNORE_DUPS       # Do not add duplicated commands to history.
setopt HIST_IGNORE_SPACE      # Do not add commands that start with space to history.
setopt HIST_NO_STORE          # Remove the history (fc -l) command from the history list.
setopt HIST_REDUCE_BLANKS     # Remove superfluous blanks from commands that being added to the history.
setopt HIST_SAVE_NO_DUPS      # When writing out the history file, omit older commands that duplicate newer ones.
setopt HIST_EXPIRE_DUPS_FIRST # Expire duplicate entries first when trimming history.
setopt HIST_VERIFY            # Don't execute the line directly instead perform history expansion.

# Input/Output
unsetopt FLOW_CONTROL         # Disable output flow control via start/stop characters (^S/^Q).
setopt INTERACTIVE_COMMENTS   # Allow comments even in interactive shells.
setopt RM_STAR_WAIT           # Before executing `rm *` first wait 10 seconds and ignore anything typed.
setopt PRINT_EXIT_VALUE       # Print the exit value of programs with non-zero exit status.

# Prompting
setopt PROMPT_SUBST           # Enable substitutions in prompt.

