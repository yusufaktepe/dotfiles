##== Completion ==##

autoload -U compinit
zmodload zsh/complist
compinit -d ~/.cache/zcompdump-${HOST}-${ZSH_VERSION}

zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'

# Complete . and .. special directories
zstyle ':completion:*' special-dirs true

# Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Automatically find new executables in path (Use pacman hook instead!)
# zstyle ':completion:*' rehash true

# Enable caching
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path $ZDOTDIR

# Complete processes in "pid, user, command" format
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"

# Colored kill command
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

# Disable named-directories autocompletion
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories

# Treat sequences of slashes in filename paths (foo//bar) as a single slash.
zstyle ':completion:*' squeeze-slashes true

# Don't complete uninteresting users
zstyle ':completion:*:*:*:users' ignored-patterns \
	adm amanda apache at avahi avahi-autoipd beaglidx bin cacti canna \
	clamav daemon dbus distcache dnsmasq dovecot fax ftp games gdm \
	gkrellmd gopher hacluster haldaemon halt hsqldb ident junkbust kdm \
	ldap lp mail mailman mailnull man messagebus mldonkey mysql nagios \
	named netdump news nfsnobody nobody nscd ntp nut nx obsrun openvpn \
	operator pcap polkitd postfix postgres privoxy pulse pvm quagga radvd \
	rpc rpcuser rpm rtkit scard shutdown squid sshd statd svn sync tftp \
	usbmux uucp vcsa wwwrun xfs '_*'

# Just show the single ignored match, don't insert it.
zstyle '*' single-ignored show

# Don't consider certain characters part of the word.
WORDCHARS=${WORDCHARS//\/[&.;]}

# Automatically find new executables after pacman transaction. (Requires alpm-hook)
trap 'rehash' USR1

# Enable completions for functions/scripts.
compdef _files cpv
compdef _dirs d
compdef _gpaste-client gpaste

_whex() {
	local -a packages packages_long
	packages_long=(/var/lib/pacman/local/*(/))
	packages=( ${${packages_long#/var/lib/pacman/local/}%-*-*} )
	compadd "$@" -a packages
}
compdef _whex whex
compdef _exec bashx

