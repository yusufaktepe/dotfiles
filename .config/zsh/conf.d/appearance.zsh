#== Appearance ==#

# Load colors
autoload -U colors && colors

# Enable ls colors
export LSCOLORS="Gxfxcxdxbxegedabagacad"
# [[ -z "$LS_COLORS" ]] && (( $+commands[dircolors] )) && eval "$(dircolors -b)"

# Set prompt
PROMPT="%B%{$fg[cyan]%}%(4~|%-1~/.../%2~|%~)%u%b >%{$fg[cyan]%}>%B%(?.%{$fg[cyan]%}.%{$fg[red]%})>%{$reset_color%}%b "

