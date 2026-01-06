#!/usr/bin/env bash
tmux set-hook -g pane-focus-in[0] 'run "#{@PLUG_ROOT}/tmux-nvim-info.tmux" \; source "~/.tmux.conf"' 
tmux set-hook -g pane-exited[0] 'run "#{@PLUG_ROOT}/tmux-nvim-info.tmux"'
