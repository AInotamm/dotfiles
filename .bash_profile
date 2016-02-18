#enables colorin the terminal bash shell export
export CLICOLOR=1

#sets up thecolor scheme for list export
export LSCOLORS=gxfxcxdxbxegedabagacad

#enables colorfor iTerm
export TERM=xterm-256color

#enables setting color
alias cls='tput reset'
alias ls='ls -G'
alias vi='vim'
#alias which='alias | /usr/bin/which --tty-only --read-alias --show-dot --show-tilde'
alias laravel="$HOME/.composer/vendor/bin/laravel"

#export extra param
export PATH="$HOME/Library/Python/2.7/bin:$HOME/.composer/vendor/bin:$PATH"

#export android sdk
export PATH="$HOME/Documents/android-sdk-macosx/platform-tools:$PATH"
