#!usr/bin/env bash
tmux setenv "@LIB_ICON" "$TMUX_ROOT/lib/app-icons.yaml"
tmux setenv '@PLUG_ROOT' "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PLUG_ROOT="$(tmux display -p "#{@PLUG_ROOT}")"
$PLUG_ROOT/lib/localhooks.sh
$PLUG_ROOT/scripts/tmux-nvim-info.sh
tmux setenv -u '@PLUG_ROOT'
