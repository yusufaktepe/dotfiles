##== Functions ==##

# List and load onto directory stack
d() { [[ -n $1 ]] && dirs "$@" || dirs -v | head -10 ;}

# Create directory and cd into it
mkcd() { command mkdir -p "$@" && cd "$_" ;}

# Prevent nested ranger instances
ranger() {
	[[ -z "$RANGER_LEVEL" ]] && command ranger "$@" || \
		echo "Shell is already running inside ranger!"
}

# Repeat given command with ${T:-3} interval
rpeat() { n=$1; shift; while [[ $(( n -= 1 )) -ge 0 ]]; do "$@"; sleep ${T:-3}; done ;}

