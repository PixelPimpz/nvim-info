#!/usr/bin/env bash
tmux setenv "@PLUG_ROOT" "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PLUG_ROOT="$(tmux display -p "#{@PLUG_ROOT}")"
tmux setenv "@LIB_ICON" "$TMUX_ROOT/lib/app-icons.yaml"
tmux source "$PLUG_ROOT/lib/localhooks.conf"
#tmux set-hook -g pane-focus-in 'display -p "rats"'
#tmux bind M-t display "$PLUG_ROOT"
tmux bind M-t run-shell "$PLUG_ROOT/scripts/get_cur_buffer.sh 1"
