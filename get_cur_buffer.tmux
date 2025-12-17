#!/usr/bin/env bash
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export LIB_ICON="$TMUX_ROOT/lib/app-icons.yaml"
source $CURRENT_DIR/lib/localhooks.conf
tmux bind M-t run-shell "$CURRENT_DIR/scripts/get_cur_buffer.sh 1"
tmux bind M-y run-shell "$CURRENT_DIR/scripts/getIcon.sh ${LIB_ICON}"
