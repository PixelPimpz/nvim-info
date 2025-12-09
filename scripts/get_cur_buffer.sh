#!/usr/bin/env bash
DEBUG=$1
ICONS="./lib/app-icons.yml"

main() {
  local PANE_PID="$(tmux display -p "#{pane_pid}")"
  local PROC="$(ps -h --ppid "${PANE_PID}" -o cmd | awk '{print $1}')"  
  if [[ "${PROC}" == "nvim" ]]; then
    local ICON=$(yq '.icons.nvim' ${ICONS} )
    local SOCKET="/tmp/$(ls /tmp | grep -E "${PANE_PID}")"
    local BUF_NAME="$( nvim --server ${SOCKET} --remote-expr 'expand("%:t")' )"
    
    if (( $DEBUG == 1 )); then 
      debug "SOCKET: ${SOCKET}"
      debug "PROC: ${PROC}"
      debug "ICON: ${ICON}"
      [[ -n "${BUF_NAME}" ]] && debug "BUF_NAME: ${BUF_NAME}" || fatal "bufname not found."  
    fi

  fi

}

set_status() {
  local STATUS="crack"
  tmux set -g @CurrentData "${STATUS}"
}

debug() {
  [[ "$1" ]] && local OUT="${1}" || local OUT="no data"
  tmux display -p "${OUT}"
}

fatal() {
  [[ -n "$1" ]] && local E="unknown error" || local E="$1"
  printf 'ERROR: %s\n' "$E" >&2
  exit 1
}

main
