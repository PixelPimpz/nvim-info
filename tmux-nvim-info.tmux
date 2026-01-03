#!usr/bin/env bash
tmux setenv "@LIB_ICON" "$TMUX_ROOT/lib/app-icons.yaml"
PLUG_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
tmux setenv '@PLUG_ROOT' "$PLUG_ROOT"
PLUG_ROOT="$(tmux display -p "#{@PLUG_ROOT}")"
tmux run $PLUG_ROOT/lib/localhooks.sh
tmux run $PLUG_ROOT/scripts/tmux-nvim-info.sh
tmux setenv -u '@PLUG_ROOT'
