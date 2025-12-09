#!/usr/bin/env bash
tmux display -p "get-cur-buffer called"
DEBUG=$1
main() {
  local PANE_PID="$(tmux display -p "#{pane_pid}")"
  local SOCKET="/tmp/$(ls /tmp | grep -E "${PANE_PID}")"
  local PROC="$(ps -h --ppid "${PANE_PID}")"  
  # -o cmd | awk '{print $1}')"
  #echo "$(ps -h --ppid "${PANE_PID}" -o cmd | awk '{print $1}')"
  #echo "$(ps -h --ppid "${PANE_PID}" -o cmd )"
  local BUF_NAME="$( nvim --server ${SOCKET} --remote-expr 'expand("%:t")' )"
  if (( $DEBUG == 1 )); then 
    debug "SOCKET: ${SOCKET}"
    debug "PROC: ${PROC}"
    [[ -n "${BUF_NAME}" ]] && debug "BUF_NAME: ${BUF_NAME}" || fatal "bufname not found."  
  fi
}

set_status() {
  local STATUS="crack"
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
