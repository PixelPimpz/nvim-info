#!/usr/bin/env bash
tmux display -p "get-cur-buffer called"
main() {
  local SOCKS="/run/user/1000"
  local PANE_PID="$(tmux display -p "#{pane_pid}")"
  tmux display -p "SOCKS: ${SOCKS}"

  local SOCKET=$(ls "${SOCKS}" | grep "${PANE_PID}"
  tmux display -p "PANE_PID: ${PANE_PID}"
  #tmux display -p "SOCKET: ${SOCKET}"
}
main
