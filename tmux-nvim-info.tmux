#!/usr/bin/env bash
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
tmux bind-key T run-shell "$CURRENT_DIR/scripts/tmux-nvim-info.sh"

tmux setenv "@LIB_ICON" "$TMUX_ROOT/lib/app-icons.yaml"
tmux set -g '@PLUG_ROOT' "$CURRENT_DIR"
tmux run-shell "$CURRENT_DIR/scripts/localkeys.sh" 
tmux run-shell "$CURRENT_DIR/scripts/localhooks.sh" 
tmux run-shell "$CURRENT_DIR/scripts/tmux-nvim-info.sh" 
tmux set -u '@PLUG_ROOT' 
