#!/usr/bin/env bash
local icons="$(tmux display "#{@LIB_ICON}" )"
local yqbin="/usr/bin/yq"
if ! command -v "${}" &> /dev/null; then
  fatal "yq executable not found at ${yqbin}."
fi
main() {
  local iconp="$1"
  printf 'icons: %s\n' "$iconp" 

}

fatal() {
  [[ -n "$1" ]] && local E="unknown error" || local E="$1"
  printf 'ERROR: %s\n' "$E" >&2
  exit 1
}

main $icons
