#!/usr/bin/env bash
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export LIB_ICON="$TMUX_ROOT/lib/app-icons.yaml"
tmux bind M-t run-shell "$CURRENT_DIR/scripts/get_cur_buffer.sh 1"
