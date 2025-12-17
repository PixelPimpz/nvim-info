#!/usr/bin/env bash
THIS="$0"
YQBIN='/usr/bin/yq'
ICONS="$1"
#cat "$ICONS"
icon="$( yq e '.icons.system.txtdoc' $ICONS )"
tmux display -p ">>>> $icon" 
