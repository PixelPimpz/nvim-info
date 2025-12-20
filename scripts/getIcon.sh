#!/usr/bin/env bash
#---------------------
DEBUG=1
ICON_NAME="$1"
## frequently used var/val
PLUG_ROOT="$( tmux display -p "#{@PLUG_ROOT}" )"
ICONS="$( tmux display -p "#{@LIB_ICON}" )"
YQBIN="/usr/bin/yq"
if ! command -v "${YQBIN}" &> /dev/null; then
  fatal "yq executable not found at ${YQBIN}."
fi


## Start main 
main() {
  [[ -z "$ICON_NAME" ]] && fatal 'ICON_NAME is null'
  local ICON="$( yq ".icons.[].${ICON_NAME}" < $ICONS | grep -v null )"
  
	if (( $DEBUG != 0 )); then
  echo "   [VARIABLE] | [VALUE] "
  echo "------------------------"
	debug "ICON_NAME:" "${ICON_NAME}" 
	debug "DEBUG:" "${ICON_NAME}" 
	debug "ICONS:" "${ICONS}" 
  debug "PLUG_ROOT:" "${PLUG_ROOT}" 
	debug "YQBIN:" "${YQBIN}" 
	debug "ICON:" "${ICON}" 
  debug "OUT:" "${out}"
	fi
  ## send ICON to stdout
  out "${ICON}"
}

out() {
  local out="$1"
  echo "${out}"
}

debug() {
  local var="$1"
  local val="$2"
  printf '%13s | %s\n' $var $val
}

## utility helpers
fatal() {
  local out="$1"
  echo "ERROR: $out."
  exit 1
}

main "${ICON_NAME}"
