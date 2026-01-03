#!usr/bin/env bash
tmux setenv "@LIB_ICON" "$TMUX_ROOT/lib/app-icons.yaml"
tmux setenv -u '@PLUG_ROOT'
tmux setenv '@PLUG_ROOT' "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
tmux run "#{@PLUG_ROOT}/lib/localhooks.sh"
tmux run "#{@PLUG_ROOT}/scripts/tmux-nvim-info.sh"
