#!/usr/bin/env bash
#
# Modeline Magic:
# http://vim.wikia.com/wiki/Modeline_magic#
#
# Modeline {
#   vi: foldmarker={,} filetype=shell foldmethod=marker foldlevel=0: tabstop=4: shiftwidth=4:
# }
#

# https://github.com/gpakosz/.tmux
# (‑●‑●)> dual licensed under the WTFPL v2 license and the MIT license,
#         without any warranty.
#         Copyright 2012— Gregory Pakosz (@gpakosz).

# Modified by Aexcm Irvin

toggle_mouse() {
    old=$(tmux show -gv mouse)
    new=""

    if [ "$old" = "on" ]; then
        new="off"
    else
        new="on"
    fi

    tmux set -g mouse $new \;\
    display "mouse: $new"
}

toggle_mouse
