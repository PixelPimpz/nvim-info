#!/usr/bin/env bash
#tmux set-hook -g pane-focus-in[0] 'source-file "${TMUX_ROOT}/tmux.conf"'
tmux set-hook -g pane-focus-in[0] 'run "echo"WTF"'
tmux set-hook -g after-new-window[1] 'tmux display "#{hook}" was called.'
tmux set-hook -g after-refresh-client[10] 'tmux source-file "${TMUX_ROOT}/tmux.conf"'
tmux set-hook -g after-refresh-client[11] 'tmux display -p "${TMUX_ROOT}/tmux.conf reloaded'
#tmux set-hook -g after-load-buffer[0] 'tmux display "#{hook}" was called.'
