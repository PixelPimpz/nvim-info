#!/usr/bin/env bash
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
tmux set-hook -g window-pane-changed[0]'tmux run-shell "$CURRENT_DIR/scripts/get_cur_buffer.sh"'
tmux set-hook -g session-window-changed[0]'tmux run-shell "$CURRENT_DIR/scripts/get_cur_buffer.sh"'
tmux set-hook -g client-session-changed[0]'tmux run-shell "$CURRENT_DIR/scripts/get_cur_buffer.sh"'
tmux run-shell "$CURRENT_DIR/scripts/get_cur_buffer.sh"
tmux bind M-t run-shell "$CURRENT_DIR/scripts/get_cur_buffer.sh"
