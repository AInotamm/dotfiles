# Load default profile
source $HOME/.bash_profile

# Autojump set
[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

# Autoload 3rd
autoload -U zsh-mime-setup select-word-style
zsh-mime-setup # run everything as if it's an executable
select-word-style base # ctrl+w on words

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

##
# Key bindings
##
# Lookup in /etc/termcap or /etc/terminfo else, you can get the right keycode
# by typing ^v and then type the key or key combination you want to use.
# "man zshzle" for the list of available actions
bindkey -e                      # emacs keybindings
bindkey '\e[1;5C' forward-word            # C-Right
bindkey '\e[1;5D' backward-word           # C-Left
bindkey '\e[2~'   overwrite-mode          # Insert
bindkey '\e[3~'   delete-char             # Del
bindkey '\e[5~'   history-search-backward # PgUp
bindkey '\e[6~'   history-search-forward  # PgDn
bindkey '^A'      beginning-of-line       # Home
bindkey '^D'      delete-char             # Del
bindkey '^E'      end-of-line             # End
bindkey '^R'      history-incremental-pattern-search-backward

# Miscellaneous
setopt interactive_comments # Comments

##
# Pushd
##
setopt auto_pushd               # make cd push old dir in dir stack
setopt pushd_ignore_dups        # no duplicates in dir stack
setopt pushd_silent             # no dir stack after pushd or popd
setopt pushd_to_home            # `pushd` = `pushd $HOME`

#
##
# History
##
HISTFILE=~/.zsh_history                                                                # where to store zsh config
HISTSIZE=10                                                                            # big history
SAVEHIST=10                                                                            # big history
HISTIGNORE="&:[ ]*:exit:halt:poweroff:shutdown:reboot:xlogout:pm-hibernate:pm-suspend" # Commands to ignore in history.
setopt append_history                                                                  # append
setopt hist_ignore_all_dups                                                            # no duplicate
unsetopt hist_ignore_space                                                             # ignore space prefixed commands
setopt hist_reduce_blanks                                                              # trim blanks
setopt hist_verify                                                                     # show before executing history commands
setopt inc_append_history                                                              # add commands as they are typed, don't wait until shell exit
setopt share_history                                                                   # share hist between sessions
setopt bang_hist                                                                       # !keyword

##
# Various
##
setopt auto_cd                  # if command is a path, cd into it
setopt auto_remove_slash        # self explicit
setopt chase_links              # resolve symlinks
setopt correct                  # try to correct spelling of commands
setopt extended_glob            # activate complex pattern globbing
setopt glob_dots                # include dotfiles in globbing
setopt print_exit_value         # print return value if non-zero
unsetopt beep                   # no bell on error
unsetopt bg_nice                # no lower prio for background jobs
unsetopt clobber                # must use >| to truncate existing files
unsetopt hist_beep              # no bell on error in history
unsetopt hup                    # no hup signal at shell exit
unsetopt ignore_eof             # do not exit on end-of-file
unsetopt list_beep              # no bell on ambiguous completion
unsetopt rm_star_silent         # ask for confirmation for `rm *' or `rm path/*'
#setxkbmap -option compose:ralt  # compose-key
print -Pn "\e]0; %n@%M: %~\a"   # terminal title

# man-help
autoload run-help
alias run-help >&/dev/null && unalias run-help
source ~/.alias                 # aliases
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias ls='ls -G'
alias la='ls -al'
alias grep='grep -color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias l.='ls -d .* --color=auto'
alias ll='ls -l --color=auto'
alias vim='sudo vim'

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="xxf"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(redis-cli git gitfast npm node autojump)

# User configuration

#export PATH=$HOME/bin:/usr/local/bin:$PATH
#export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LC_ALL=en_US.UTF-8 
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
else
   export EDITOR='vim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Load zsh-syntax-highlighting.
source $HOME/Documents/Github/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Load zsh-autosuggestions.
#source ~/.zsh/zsh-autosuggestions/autosuggestions.zsh

# Enable autosuggestions automatically.
#zle-line-init() {
#    zle autosuggest-start
#}
#zle -N zle-line-init

# Enable Incrmental Completions
source $ZSH/plugins/incr/incr*.zsh

# Powerline
export POWERLINE_ROOT=/Library/Python/2.7/site-packages/powerline

#if [ -d $POWERLINE_ROOT ]; then
#	POWERLINE_BASH_CONTINUATION=1
#	POWERLINE_BASH_SELECT=1
#	source $POWERLINE_ROOT/bindings/zsh/powerline.zsh
#fi

#  To achieve this we let tmux save the path each time the shell prompt is displayed
PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'
