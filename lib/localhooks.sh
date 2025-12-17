#!/usr/bin/env bash
tmux set-hook -g pane-focus-in[0] 'run-shell "#{@PLUG_ROOT}/scripts/get_cur_buffer.sh"'
tmux set-hook -g after-new-window[1] 'run-shell "#{@PLUG_ROOT}/scripts/get_cur_buffer.sh"'
