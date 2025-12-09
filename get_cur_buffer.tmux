#!/usr/bin/env bash
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
tmux set-hook -g window-pane-changed 'tmux run-shell "$CURRENT_DIR/scripts/get_cur_buffer.sh 1"'
tmux set-hook -g session-window-changed 'tmux run-shell "$CURRENT_DIR/scripts/get_cur_buffer.sh 1"'
tmux set-hook -g client-session-changed 'tmux run-shell "$CURRENT_DIR/scripts/get_cur_buffer.sh 1"'
tmux run-shell "$CURRENT_DIR/scripts/get_cur_buffer.sh 1"
tmux bind M-t run-shell "$CURRENT_DIR/scripts/get_cur_buffer.sh 1"
