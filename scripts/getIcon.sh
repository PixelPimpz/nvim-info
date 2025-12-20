#!/usr/bin/env bash
local icons="$(tmux display "#{@LIB_ICON}" )"
local yq-bin="/usr/bin/yq"
if ! command -v "${yq-bin}" &> /dev/null; then
  fatal "yq executable not found at ${YQBIN}."
fi
main() {
  printf 'icons: %s\n' "$icons" 

}

fatal() {
  [[ -n "$1" ]] && local E="unknown error" || local E="$1"
  printf 'ERROR: %s\n' "$E" >&2
  exit 1
}

main
