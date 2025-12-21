p!/usr/bin/env bash
tmux set-hook -g pane-focus-in[0] 'run "#{@PLUG_ROOT}/scripts/get_cur_buffer.sh'
tmux set-hook -g after-new-window[1] 'run "#{@PLUG_ROOT}/scripts/get_cur_buffer.sh'
tmux set-hook -g after-refresh-client[11] 'display -p "${TMUX_ROOT}/tmux.conf reloaded'
tmux set-hook -g pane-died[0] 'display -p "pane: #{pane_pid}" has exited.'
