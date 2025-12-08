#!/usr/bin/env bash
tmux display -p "get-cur-buffer called"
DEBUG=$1
BUF_NAME="unknown"
main() {
  local SOCKS="/tmp"
  local PANE_PID="$(tmux display -p "#{pane_pid}")"
  local SOCKET="${SOCKS}/$(ls "${SOCKS}" | grep "${PANE_PID}")"
  BUF_NAME="$( nvim --server "${SOCKET}" --remote-expr 'bufname("%:t")' )"
  if (( $DEBUG == 1 )); then 
    debug 
  fi
}

debug() {
  tmux display -p "PANE_PID: ${PANE_PID}"
  tmux display -p "SOCKS: ${SOCKS}"
  tmux display -p "SOCKET: ${SOCKET}"
  tmux display -p "BUF_NAME: ${BUF_NAME}"
}
main
