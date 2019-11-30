# My dotfiles
This repository contains the configs and scripts for my GNU/Linux installation.

## Programs whose configs can be found here
- i3-gaps
- i3blocks
- neovim
- zsh
- rofi
- picom
- dunst
- sxiv
- lf
- git
- ...
- And many scripts I use resides in the [`~/.local/bin`](./.local/bin) directory

## Some notes
- I use the [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html) for my configs whenever it's possible. Some environment variables have been set in [`~/.profile`](./.profile) and [`~/.pam_environment`](./.pam_environment) to move configs into specified directories.
- I don't use a login manager. i3 session automatically starts on tty1 login.
- Vi-mode enabled in my shell config and cursor shape changes depending on the mode.
- <kbd>CapsLock</kbd> is mapped to <kbd>Hyper_L</kbd>, which gives me an extra modifier and behaves like <kbd>Escape</kbd> when it's used alone. Referenced as `$caps` in i3 config.
- Following symlinks and wrappers created at the system level:
	- sh &rightarrow; dash
	- vim &rightarrow; nvim
	- dmenu &rightarrow; rofi
	- [*xdg-wrappers*](https://github.com/yusufaktepe/xdg-wrappers)
- Some of the programs I frequently use added to sudo exceptions, so they don't require a password. (ps_mem, updatedb...)
