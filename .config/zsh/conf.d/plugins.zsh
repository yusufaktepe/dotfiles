##== Plugins ==##

# zsh-autosuggestions: fish-like auto-suggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# zsh-syntax-highlighting: fish-like syntax highlighting
# !!! needs to be loaded before history-substring-search
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# zsh-history-substring-search: fish-like history search
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

# pkgfile: "command not found" hook
source /usr/share/doc/pkgfile/command-not-found.zsh 2>/dev/null

# zsh-system-clipboard
ZSH_SYSTEM_CLIPBOARD_SELECTION='PRIMARY'
source /usr/share/zsh/plugins/zsh-system-clipboard/zsh-system-clipboard.zsh 2>/dev/null

