#!/usr/bin/env bash
THIS="$0"
ICONS="$1"
YQBIN='/usr/bin/yq'
#cat "$ICONS"
icon="$( yq e '.icons.system.txtdoc' $ICONS )"
echo "$icon"

