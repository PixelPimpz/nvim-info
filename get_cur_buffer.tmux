#!/usr/bin/env bash
tmux setenv "@PLUG_ROOT" "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
tmux setenv "@LIB_ICON" "$TMUX_ROOT/lib/app-icons.yaml"
PLUG_ROOT="$(tmux display "#{@PLUG_ROOT}")"
tmux set-hook -g pane-focus-in 'display -p "rats"'
tmux bind M-t run 'PLUG_ROOT="$( tmux display -p "#{@PLUG_ROOT}")";/bin/bash "$PLUG_ROOT/scripts/get_cur_buffer.sh"'

#tmux bind M-t run-shell "$PLUG_ROOT/scripts/get_cur_buffer.sh 1"
tmux bind M-y run-shell "$PLUG_ROOT/scripts/getIcon.sh "$(tmux display -p "#{@LIB_ICON}")""
