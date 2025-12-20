#!/usr/bin/env bash
#---------------------
DEBUG=1
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
  local icon="$( yq '.icons.[].warning' < $ICONS | grep -v null )"
  
	if (( $DEBUG != 0 )); then
	  debug "ICON_NAME" "${ICON_NAME}" 
	fi
}

debug() {
  local var="$1"
  local val="$2"
  echo "=======[debug]======="
  printf '%10s | %s\n' $var $val
}

## utility helpers
fatal() {
  local out="$1"
  echo "ERROR: $out."
  exit 1
}

main "${ICON_NAME}"
