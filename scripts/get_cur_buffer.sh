#!/usr/bin/env bash
tmux display -p "get-cur-buffer called"
main() {
  local PANE_PID="$(tmux display -p "PANE_PID: #{pane_pid}")"
  tmux display -p "${PANE_PID}"
}
main
