foreach conf (
	options.zsh
	appearance.zsh
	completion.zsh
	aliases.zsh
	functions.zsh
	plugins.zsh
	keys.zsh
	termtitle.zsh
) {
	source $ZDOTDIR/conf.d/$conf
}
unset conf
