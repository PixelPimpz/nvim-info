#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Bind 'T' (after the tmux prefix, usually Ctrl+b) to run a script
tmux bind-key T run-shell "$CURRENT_DIR/scripts/tmux-nvim-info.sh"

tmux setenv "@LIB_ICON" "$TMUX_ROOT/lib/app-icons.yaml"
tmux setenv -u '@PLUG_ROOT'
tmux setenv '@PLUG_ROOT' "$CURRENT_DIR"
tmux run "#{@PLUG_ROOT}/lib/localhooks.sh"
tmux run "#{@PLUG_ROOT}/scripts/tmux-nvim-info.sh"
