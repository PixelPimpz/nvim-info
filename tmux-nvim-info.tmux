#!/usr/bin/env bash
LOCAL_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
tmux bind-key T run-shell "$LOCAL_ROOT/scripts/tmux-nvim-info.sh"

tmux setenv "@LIB_ICON" "$TMUX_ROOT/lib/app-icons.yaml"
tmux set -g '@NVIM_INFO_ROOT' "$LOCAL_ROOT"
tmux run-shell "$LOCAL_ROOT/scripts/localkeys.sh" 
tmux run-shell "$LOCAL_ROOT/scripts/localhooks.sh" 
tmux run-shell "$LOCAL_ROOT/scripts/tmux-nvim-info.sh" 
