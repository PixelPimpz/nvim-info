#!/usr/bin/env bash
ICONS="$( tmux display-message -p "#{@LIB_ICON}" )"
YQBIN="/usr/bin/yq"

if ! command -v "${YQBIN}" &> /dev/null; then
  fatal "yq executable not found at ${YQBIN}."
fi

tmux display "$ICONS"

main() {

}

fatal() {
  local out="$1"
  printf 'ERROR: %s \n' $out
  exit 1
}
