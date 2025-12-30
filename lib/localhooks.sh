#!/usr/bin/env bash
tmux set-hook -g pane-focus-in[0] 'run "#{@PLUG_ROOT}/get_cur_buffer' 
tmux set-hook -g pane-exited[0] 'run "#{@PLUG_ROOT}/get_cur_buffer"'
tmux set-hook -g session-created[0] 'run "#{@PLUG_ROOT}/get_cur_buffer"'
tmux set-hook -g session-window-changed[0] 'run "#{@PLUG_ROOT}/get_cur_buffer"'
tmux set-hook -g after-new-window[0] 'run "#{@PLUG_ROOT}/get_cur_buffer"'
tmux set-hook -g after-new-session[0] 'run "#{@PLUG_ROOT}/get_cur_buffer"'
tmux set-hook -g session-changed[0] 'run "#{@PLUG_ROOT}/get_cur_buffer"'
tmux set-hook -g session-changed[1] 'refresh-client'
