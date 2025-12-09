#!/usr/bin/env bash
tmux display -p "get-cur-buffer called"
DEBUG=$1
main() {
  local SOCK_GEN="$(tmux display -p "/tmp/nvim-#{pane_pid}")"
  local SOCKET="$(ls /tmp | grep -E "${SOCK_GEN}")"
  tmux display -p "$(ls /tmp | grep "nvim" )"
#  local BUF_NAME="$( nvim --server ${SOCKET} --remote-expr 'bufname("%:t")' )"
  if (( $DEBUG == 1 )); then 
    debug "SOCK_GEN: ${SOCK_GEN}"
    debug "SOCKET: ${SOCKET}"
    [[ -n "${BUF_NAME}" ]] && fatal "bufname not found." || debug "${BUF_NAME}"
  fi
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
