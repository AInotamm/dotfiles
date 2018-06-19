# cat << EOF > /dev/null
# https://github.com/AInotamm/.dotfile
# Aexcm Irvin's ZSH configuration
#
# Modeline Magic:
# http://vim.wikia.com/wiki/Modeline_magic#
#
# Modeline {
#	vi: foldmarker={,} filetype=zsh foldmethod=marker foldlevel=0: tabstop=4: shiftwidth=4:
# }
#

# Environment {
	# Path to your oh-my-zsh installation.
	export ZSH=$HOME/.oh-my-zsh
	
	typeset -U path		# Don't add entry to path if it's already present.
	#path=(~/tmp $path)

	# Function paths.
	#fpath=(~/.zsh_funcs $fpath)
	fpath=(/usr/local/share/zsh-completions /usr/local/share/zsh/site-functions $fpath)
# }

# Common shell settings.
if [[ -f $HOME/.shell_commons && -r $HOME/.shell_commons ]]; then
	export my_shell=zsh
	export completion=compctl
	# Load Command Default Setting
	source $HOME/.shell_commons
fi

# Completion {
	zstyle ':completion:*' completer _oldlist _expand _complete _ignored _correct _approximate
	zstyle ':completion:*' max-errors 3 numeric
	# Ignore any function names beginning with an underscore
	zstyle ':completion:*:functions' ignored-patterns '_*'
	# Visualize and selecting with arrow keys in completion.
	zstyle ':completion:*' menu select
	# Remove slash from completed directory.
	zstyle ':completion:*' squeeze-slashes true
	# Cache completions.
	zstyle ':completion:*' use-cache onzstyle ':completion:*' use-cache on
	zstyle ':completion:*' cache-path ~/.zsh/cache
	# Honor LS_COLORs in completion.
	zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
	# Ignore case in tab complete. http://www.rlazo.org/2010/11/18/zsh-case-insensitive-completion/
	zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' \
    	    'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
    # Completing process IDs with menu selection:
	zstyle ':completion:*:*:kill:*' menu yes select
	zstyle ':completion:*:kill:*'   force-list always
	# Style if no matching completion is found.
	zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
	# Disable hostname completion
	zstyle ':completion:*' hosts off

	# Complete options for aliases too.
	setopt completealiases
	# List files when cd-completing.
	$completion _path_files cd

	autoload -Uz compinit
	compinit -C
# }

# History {
	export HISTFILE=~/.zsh_history		# Where to save history.
	export HISTSIZE=1000			# Big history.
	export SAVEHIST=20			# Big history.

	# Commands to ignore in history. Separate with |. *-matching. 
	export HISTIGNORE="&:[ ]*:exit:halt:poweroff:shutdown:reboot:xlogout:pm-hibernate:pm-suspend"

	setopt appendhistory		# Append to history write on exit, don't overwrite.
	setopt banghist			# !Keyword
	setopt extendedhistory		# Save command time start and exec time in seconds.
	setopt histignorealldups	# Don't save immediate duplicates lines in history.
	setopt histignorespace		# Ignore commands starting with space.
	setopt histreduceblanks	# Trim blanks
	setopt histverify		# Show before executing history commands
	setopt incappendhistory	# Add commands as they are typed, don't wait until shell exit
	setopt sharehistory		# Share hist between sessions
# }

# UI {
	# Set name of the theme to load.
	# Look in ~/.oh-my-zsh/themes/
	# Optionally, if you set this to "random", it'll load a random theme each
	# time that oh-my-zsh is loaded.
	ZSH_THEME="spaceship"

	# Get the colors
	autoload colors zsh/terminfo

	if [[ "$terminfo[colors]" -ge 8 ]]; then
		colors
	fi

	for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE GREY; do
		eval C_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
		eval C_L_$color='%{$fg[${(L)color}]%}'
	done

	C_OFF="%{$terminfo[sgr0]%}"	

	# Prompt {
		# Set the prompt
		set_prompt() {
  			mypath="$C_OFF$C_L_GREEN%~"
  			myjobs=()
  			for a (${(k)jobstates}) {
    				j=$jobstates[$a];i="${${(@s,:,)j}[2]}"
    				myjobs+=($a${i//[^+-]/})
  			}
  			myjobs=${(j:,:)myjobs}
  			((MAXMID=$COLUMNS / 2)) # truncate to this value
  			rehash
		}

		# Load prompt functions
		setopt promptsubst
		unsetopt transient_rprompt # leave the pwd

		precmd() {
  			set_prompt
  			print -Pn "\e]0;%n@$__IP:%l\a"
		}
	# }
	
	# Themes {
	    # Issues with git module when path contains spaces #343
	    SPACESHIP_DIR_TRUNC_REPO=false
        # Show exit code of last command
	    SPACESHIP_EXIT_CODE_SHOW=true
	    # Show time
	    SPACESHIP_TIME_SHOW=true
	    # Format time using 12-hour clock (am/pm)
	    SPACESHIP_TIME_12HR=true
	# }
# }

# Options {
	# Manual & categories: http://zsh.sourceforge.net/Doc/Release/Options.html

	# Changing Directories {
		setopt autocd			# If command is a path, cd into it
		setopt autopushd		# Make cd push old dir in dir stack
		setopt pushdignoredups	# No duplicates in dir stack
		setopt pushdsilent		# No dir stack after pushd or popd
		setopt pushdtohome		# Pushd with no args pushes $HOME.
	# }

	# Glob {
		setopt extendedglob		# activate complex pattern globbing
		setopt globdots		    # include dotfiles in globbing
	# }

	# Input/Output {
		unsetopt correct correctall 	# Don't encourage sloppy typing.
	# }

	# Miscellaneous {
	#	setopt interactive_comments	# Comments
	# }

	# Job Control {
		setopt longlistjobs		# Display PID when suspending processes.
		unsetopt bgnice			# No lower prio for background jobs
	# }

	# Shell Emulation {
		setopt shnullcmd		# Truncate like in bash e.g. $(>file).
		unsetopt printexitvalue	# Print return value if non-zero
		unsetopt clobber		# Must use >| to truncate existing files
	# }

	# ZLE {
		setopt autoremoveslash		# Self explicit
		setopt chaselinks		    # Resolve symlinks
		setopt nobeep			    # No beeps thanks!		
		unsetopt printexitvalue		# Do not print return value if non-zero but plugin support it
		unsetopt hup			    # No hup signal at shell exit
		unsetopt ignoreeof		    # Do not exit on end-of-file
		unsetopt rmstarsilent		# Ask for confirmation for `rm *' or `rm path/*'
	#}

	print -Pn "\e]0; %n@%M: %~\a"		# Terminal title
# }

# Bindings {
	# Lookup in /etc/termcap or /etc/terminfo else, you can get the right keycode
	# by typing ^v and then type the key or key combination you want to use.
	# "man zshzle" for the list of available actions
	bindkey -e                                              # emacs keybindings
	bindkey -M viins '\e/' vi-search-fix
	bindkey -M vicmd v edit-command-line
	bindkey '\e[1;5C' forward-word            				# C-Right
	bindkey '\e[1;5D' backward-word           				# C-Left
	bindkey '\e[2~'   overwrite-mode          				# Insert
	bindkey '\e[3~'   delete-char             				# Del
	bindkey '\e[5~'   history-search-backward 				# PgUp
	bindkey '\e[6~'   history-search-forward  				# PgDn
	bindkey '^A'      beginning-of-line       				# Home
	bindkey '^D'      delete-char             				# Del
	bindkey '^E'      end-of-line             				# End
	bindkey '^R'      history-incremental-pattern-search-backward
# }


# ZLE {
	# Let  / search in vi mode. Defined in ~/.zsh_funcs/vi-search-fix
	# Reference: http://superuser.com/questions/476532/how-can-i-make-zshs-vi-mode-behave-more-like-bashs-vi-mode
	autoload vi-search-fix
	zle -N vi-search-fix

	# Visual mode in vi-mode, like in bash.
	autoload -U edit-command-line
	zle -N edit-command-line

	# Enable help command for zsh functions.
	autoload -U run-help
	autoload run-help-git run-help-svn run-help-svk
# }

# ZSH EXTRAS {
	# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
	# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
	# Example format: plugins=(rails git textmate ruby lighthouse)
	# Add wisely, as too many plugins slow down shell startup.
	plugins=(zsh-autosuggestions zsh-syntax-highlighting vi-mode sudo nice-exit-code) 

	# Load default profile
	source $ZSH/oh-my-zsh.sh
# }

# Programs {
	# Autojump {
	#    [[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh
	# }
	
	# FASD {
	    eval "$(fasd --init auto)"
	# }
		
	# Fuck Command {
	    eval $(thefuck --alias)
	# }
	
	# Fuzzy Finder {
	    [ -f ~/.zsh_funcs/.fzf.zsh ] && source ~/.zsh_funcs/.fzf.zsh
	# }

	# Auto-Suggestions {
		ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=243'
	# }

	# Incr-Completions {
	#	source $ZSH/plugins/incr/incr*.zsh
	# }

    # MIME WORDS {
		autoload -U zsh-mime-setup select-word-style
		zsh-mime-setup								# Run everything as if it's an executable
		select-word-style base						# Ctrl+w on words
	# }


	# Powerline {
    #	if [ $POWERLINE_ROOT ] && [ -d $POWERLINE_ROOT ]; then
	#		POWERLINE_BASH_SELECT=1
	#		POWERLINE_BASH_CONTINUATION=1
	#		source $POWERLINE_ROOT/bindings/zsh/powerline.zsh
	#	fi
	# }

	# TMUX {
		#  To achieve this we let tmux save the path each time the shell prompt is displayed
		PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'
	# }
	
	# Interactive CD {
	    source $ZSH_CUSTOM/plugins/zsh-interactive-cd/zsh-interactive-cd.plugin.zsh
	# }
# }

