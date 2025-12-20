#!/usr/bin/env bash
#---------------------
ICON_NAME="$1"
## frequently used var/val
PLUG_ROOT="$( tmux display "#{@PLUG_ROOT}" )"
ICONS="$( tmux display-message -p "#{@LIB_ICON}" )"
YQBIN="/usr/bin/yq"
if ! command -v "${YQBIN}" &> /dev/null; then
  fatal "yq executable not found at ${YQBIN}."
fi

## Start main 
main() {
  [[ -z "$ICON_NAME" ]] && fatal 'ICON_MANE is null'
  yq '.icons.system.warning' < $ICONS
  tmux display -p "$ICONS"
}

## utility helpers
fatal() {
  local out="$1"
  echo "ERROR: $out."
  exit 1
}

main "${ICON_NAME}"
