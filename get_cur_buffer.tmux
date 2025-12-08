#!/usr/bin/env bash
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
tmux set-hook -g window-pane-changed 'tmux display -p "window-pane-changed"'
tmux set-hook -g session-window-changed 'tmux display -p "session-window-changed"'
tmux set-hook -g client-session-changed 'tmux display -p "client-session-changed"'
#tmux run-shell "$CURRENT_DIR/scripts/get_cur_buffer.sh 1"
tmux bind M-t run-shell "$CURRENT_DIR/scripts/get_cur_buffer.sh 1"
