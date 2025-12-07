#!/usr/bin/env bash
tmux display -p "get-cur-buffer called"
DEBUG=$1
main() {
  local SOCKS="/run/user/1000"
  local PANE_PID="$(tmux display -p "#{pane_pid}")"
  local SOCKET="$(ls "${SOCKS}" | grep "${PANE_PID}")"
  (( $DEBUG == 1 )) && debug 
}

debug() {
  tmux display -p "PANE_PID: ${PANE_PID}"
  tmux display -p "SOCKS: ${SOCKS}"
  tmux display -p "SOCKET: ${SOCKET}"
}
main
