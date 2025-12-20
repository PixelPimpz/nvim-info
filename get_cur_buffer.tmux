#!/usr/bin/env bash
tmux setenv "@PLUG_ROOT" "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PLUG_ROOT="$(tmux display -p "#{@PLUG_ROOT}")"
tmux setenv "@LIB_ICON" "$TMUX_ROOT/lib/app-icons.yaml"
$PLUG_ROOT/lib/localhooks.sh
$PLUG_ROOT/scripts/get_cur_buffer.sh
tmux bind-key M-t run "$PLUG_ROOT/scripts/getIcon.sh "warning""
