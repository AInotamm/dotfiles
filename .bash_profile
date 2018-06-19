# Bash Profile
# NOTE Login shells read ~/.profile, normal and interactive shells read ~/.bashrc.
# But this is MAC OS X, this always use LOGIN SHELL.

# Modeline {
#	vi: foldmarker={,} filetype=sh foldmethod=marker foldlevel=0: tabstop=4 shiftwidth=4:
# }

# Source global profile.
# NOTE resets PATH
if  [ -f /etc/profile ]  && [ -r /etc/profile ]; then
	source /etc/profile
fi

if [ -f $HOME/.shell_commons ] && [ -r $HOME/.shell_commons ]; then
	export my_shell=bash
	export completion=complete
	# Load Command Default Setting
	source $HOME/.shell_commons
fi

# Completion {
    # Complete @hostnames in a file with /ets/hosts format.
    HOSTFILE=/etc/hosts

    # Enable bash tab completion. Not needed with package 'bash-completion' installed.
    complete -cf sudo
    complete -cf man

    # Enable extra bash completion
    [ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
# }

# History {
	# Number lines to store in active bash session.
	export HISTSIZE=100000
	# Number lines to store in history file after session end.
	export HISTFILESIZE=100000
	# Don't put duplicate commands in the history.
	export HISTCONTROL="erasedups:ignoreboth"
	# Commands to ignore in history.
	# TODO poweroff logged somehow, why?
	export HISTIGNORE="&:[ ]*:exit:halt:poweroff:shutdown:reboot:xlogout:pm-hibernate:pm-suspend"
	# Append instead of overwrite history on exit.
	shopt -s histappend
	# Allow multiline commands as one command.
	shopt -s cmdhist
# }

# UI {
	# Source PS1 configuration.
	sourceifexists "$HOME/.bash_ps1"

	# Check the window size after each command and, if necessary, update the values of LINES and COLUMNS.
	shopt -s checkwinsize

	# Colored man pages.
	# Reference: https://wiki.archlinux.org/index.php/Man_Page#Colored_man_pages
	man() {
		env \
		LESS_TERMCAP_mb=$(printf "\e[1;31m") \
		LESS_TERMCAP_md=$(printf "\e[1;31m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[1;32m") \
			man "$@"
	}
# }
