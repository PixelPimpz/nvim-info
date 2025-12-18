#!/usr/bin/env bash
tmux set-hook -g pane-focus-in[0] 'tmux display "#{hook}" was called.'
tmux set-hook -g after-new-window[1] 'tmux display "#{hook}" was called.'
#tmux set-hook -g after-load-buffer[0] 'tmux display "#{hook}" was called.'
