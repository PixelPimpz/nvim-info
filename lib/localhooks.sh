#!/usr/bin/env bash
tmux set-hook -g pane-focus-in[0] 'run "#{@PLUG_ROOT}/scripts/get_cur_buffer.sh \; refresh-client'
tmux set-hook -g session-created[0] 'run "#{@PLUG_ROOT}/get_cur_buffer"'
tmux set-hook -g session-window-changed[0] 'run "#{@PLUG_ROOT}/get_cur_buffer"'
tmux set-hook -g after-new-window[1] 'run "#{@PLUG_ROOT}/get_cur_buffer"'
tmux set-hook -g after-new-session[1] 'run "#{@PLUG_ROOT}/get_cur_buffer"'
tmux set-hook -g sessions-changed[1] 'run "#{@PLUG_ROOT}/get_cur_buffer"'
tmux set-hook -g after-refresh-client[11] ''
