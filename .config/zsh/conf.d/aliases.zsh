##== Aliases ==##

alias cp='cp -iv'
alias mv='timeout 8 mv -iv'
alias rm='timeout 3 rm -Iv --one-file-system'
alias mkdir='mkdir -pv'
alias ln='ln -iv'
alias df='df -h'
alias du='du -h'
alias info='info --vi-keys'
alias ffmpeg='ffmpeg -hide_banner'
alias ncdu='ncdu --color dark'
alias ncmpcpp='pkill -0 mpd || mpd && ncmpcpp -q'
alias newsboat='newsboat -q'
alias ssh='TERM=xterm-256color ssh'
alias ps_mem='sudo ps_mem'
alias updatedb='sudo updatedb'

alias didi='sudo dd bs=4M oflag=sync status=progress'
alias magit='nvim -c MagitOnly'
alias mkd='mkdir -pv'
# alias fcd='. ranger'
alias fcd='cd $(vifm -c "session select | cd $PWD" --choose-dir -)'

alias cpr='rsync -avzz --progress -h'
alias cpru='cpr -u'
alias mvr='rsync -avzz --progress -h --remove-source-files'
alias dirsync='rsync -avzzu --delete --progress -h'

alias e='$EDITOR' v='$EDITOR'
alias f='vifm -c "session shell"'
alias g='git'
alias p='sudo pacman'
alias se='sudoedit'
alias ka='killall'
alias wb='$BROWSER'
alias yt='youtube-dl --add-metadata -i'
alias yta='yt -x -f bestaudio/best'
alias YT='youtube-viewer'

alias lspath='printf "%b\n" "${PATH//:/\\n}"'
alias mktree='tree -a -I .git > TREE'
alias mkpkg='makepkg -srci'
alias mksrci='makepkg --printsrcinfo > .SRCINFO'
alias paclog="grep -E '\] (install|upgrad|remov)ed' /var/log/pacman.log | less +G"

# Colorize commands
alias ls='ls --group-directories-first --time-style=long-iso --color=auto -F'
alias ll='ls -l'
alias la='ls -lah'
alias grep='grep --color=auto --exclude-dir=".git" --exclude-dir="node_modules"'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias diff='diff --color=auto'
alias ccat='highlight --out-format=ansi'

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

alias -g NUL=">/dev/null 2>&1"
alias -g N=">/dev/null"
alias -g NA="&>/dev/null"
alias -g N1="1>/dev/null"
alias -g N2="2>/dev/null"

