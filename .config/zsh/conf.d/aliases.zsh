##== Aliases ==##

alias cp='cp -riv'
alias mv='timeout 8 mv -iv'
alias rm='timeout 3 rm -Iv --one-file-system'
alias mkdir='mkdir -pv'
alias ln='ln -iv'
alias df='df -h'
alias du='du -h'
alias info='info --vi-keys'
alias diff='git diff --no-index'
alias ffmpeg='ffmpeg -hide_banner'
alias ncdu='ncdu --color dark --exclude vifm/fuse'
alias ncmpcpp='pkill -0 mpd || mpd && ncmpcpp -q'
alias newsboat='newsboat -q'
alias ssh='TERM=xterm-256color ssh'
alias tree='tree -aI ".git|node_modules" --dirsfirst'
alias vidir='vidir -v'
alias wget='wget -qc --show-progress'
alias reboot='mpvc quit 2>/dev/null; systemctl reboot'

for p in iotop ps_mem updatedb; { alias $p="sudo $p" ;}; unset p

alias didi='sudo dd bs=4M oflag=sync status=progress'
alias magit='nvim -c MagitOnly'
alias mkd='mkdir -pv'
alias fcd='cd "$(VIFM=~/.config/vifm/sessions/select vifm --choose-dir - .)"'
alias gr='cd "$(git rev-parse --show-toplevel)"'

alias cpr='rsync -avzzPh'
alias cpru='cpr -u'
alias mvr='rsync -avzzPh --remove-source-files'
alias dirsync='rsync -avzzPhu --delete'

alias e='$EDITOR' v='$EDITOR'
alias f='VIFM=~/.config/vifm/sessions/shell vifm'
alias g='git'
alias p='sudo pacman'
alias se='sudoedit'
alias ka='killall'
alias yt='yt-dlp --embed-metadata -i'
alias yta='yt -x -f bestaudio/best'
alias YT='youtube-viewer'

alias publicip='curl -sf ifconfig.co'
alias lspath='printf "%b\n" "${PATH//:/\\n}"'
alias mktree='tree -a -I .git > TREE'
alias mkpkg='makepkg -srci'
alias mksrci='makepkg --printsrcinfo > .SRCINFO'
# alias paclog='grep -E "\] (install|upgrad|remov)ed" /var/log/pacman.log | less +G'
alias pacmanlog='paclog $(printf " --action %s" {install,{up,down}grade,remove})'
alias http-serve='python -m http.server'

# Colorize commands
# alias ls='ls --group-directories-first --time-style=long-iso --color=auto -F'
# alias la='ls -lah'
alias ls='exa --group-directories-first --time-style=long-iso --icons -Fg'
alias ll='ls -l --git'
alias la='ls -la --git'
alias grep='grep --color=auto --exclude-dir=".git" --exclude-dir="node_modules"'
# alias diff='diff --color=auto'
alias ccat='highlight --out-format=ansi'
alias ip='ip -color'

# Shell history
alias h='history'
alias vH='$EDITOR + $HISTFILE'

# Dir stack
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

# Global Aliases
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

