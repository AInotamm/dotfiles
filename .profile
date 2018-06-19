# 登录SHELL执行时会读取该文件，但是交互式SHELL只会读取.bashrc.在此可以进行语言设置.

# vi: foldmarker={,} foldmethod=marker foldlevel=4: tabstop=4 shiftwidth=4:

# You may need to manually set your language environment
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Read global configuration.
if [ -f /etc/profile ]; then
	source /etc/profile
fi

if [ -f $HOME/.shell_profile ]; then
	source $HOME/.shell_profile
fi

# Source bashrc. Most of the settings there are relevant also for login shells.
if [ -n "$BASH" ] && [ -f $HOME/.bashrc ]; then
    source $HOME/.bashrc
fi

export PATH
