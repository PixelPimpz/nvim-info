#!/usr/bin/env bash
tmux set-hook -g pane-focus-in[0] 'run-shell "#{@PLUG_ROOT}/scripts/get_cur_buffer.sh"'
