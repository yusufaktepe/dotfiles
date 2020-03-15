##== Set Terminal Title ==##

title() {
	emulate -L zsh
	setopt prompt_subst

	: ${2=$1} # if $2 is unset use $1; if it is set and empty, leave it as is

	case "$TERM" in
		xterm*|rxvt*|konsole*|ansi)
			print -Pn "\e]2;$2:q\a" # set window name
			print -Pn "\e]1;$1:q\a" # set tab name
		;;
		screen*|tmux*)
			print -Pn "\ek$1:q\e\\" # set screen hardstatus
		;;
		*)
			# Try to use terminfo to set the title
			# If the feature is available set title
			if [[ -n "$terminfo[fsl]" ]] && [[ -n "$terminfo[tsl]" ]]; then
				echoti tsl
				print -Pn "$1"
				echoti fsl
			fi
	esac
}

TERM_TAB_TITLE_IDLE="%15<..<%~%<<" #15 char left truncated PWD
TERM_TITLE_IDLE="%n@%m: %~"

# Runs before showing the prompt
termtitle_precmd() {
	title $TERM_TAB_TITLE_IDLE $TERM_TITLE_IDLE
}

# Runs before executing the command
termtitle_preexec() {
	emulate -L zsh
	setopt extended_glob

	# split command into array of arguments
	local -a cmdargs
	cmdargs=("${(z)2}")
	# if running fg, extract the command from the job description
	if [[ "${cmdargs[1]}" = fg ]]; then
		# get the job id from the first argument passed to the fg command
		local job_id jobspec="${cmdargs[2]#%}"
		# logic based on jobs arguments:
		# http://zsh.sourceforge.net/Doc/Release/Jobs-_0026-Signals.html#Jobs
		# https://www.zsh.org/mla/users/2007/msg00704.html
		case "$jobspec" in
			<->) # %number argument:
				# use the same <number> passed as an argument
				job_id=${jobspec} ;;
			""|%|+) # empty, %% or %+ argument:
				# use the current job, which appears with a + in $jobstates:
				# suspended:+:5071=suspended (tty output)
				job_id=${(k)jobstates[(r)*:+:*]} ;;
			-) # %- argument:
				# use the previous job, which appears with a - in $jobstates:
				# suspended:-:6493=suspended (signal)
				job_id=${(k)jobstates[(r)*:-:*]} ;;
			[?]*) # %?string argument:
				# use $jobtexts to match for a job whose command *contains* <string>
				job_id=${(k)jobtexts[(r)*${(Q)jobspec}*]} ;;
			*) # %string argument:
				# use $jobtexts to match for a job whose command *starts with* <string>
				job_id=${(k)jobtexts[(r)${(Q)jobspec}*]} ;;
		esac

		# override preexec function arguments with job command
		if [[ -n "${jobtexts[$job_id]}" ]]; then
			1="${jobtexts[$job_id]}"
			2="${jobtexts[$job_id]}"
		fi
	fi

	# cmd name only, or if this is sudo or ssh, the next cmd
	local CMD=${1[(wr)^(*=*|sudo|ssh|mosh|rake|-*)]:gs/%/%%}
	local LINE="${2:gs/%/%%}"

	title '$CMD' '%100>...>$LINE%<<'
}

autoload -U add-zsh-hook
add-zsh-hook precmd termtitle_precmd
add-zsh-hook preexec termtitle_preexec

