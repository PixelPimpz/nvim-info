#!/usr/bin/env bash
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PLUG_ROOT="${CURRENT_DIR%/*}"
ICONS="${CURRENT_DIR}/../lib/app-icons.yml"
YQ_BIN='/usr/bin/yq'

DEBUG=$1

main() {
  if ! command -v "${YQ_BIN}" &> /dev/null; then
    fatal "yq executable not found at ${YQ_BIN}."
  fi
  
  local PANE_PID="$(tmux display -p "#{pane_pid}")"
  local PROC="$(ps -h --ppid "${PANE_PID}" -o cmd | head -n 1 | awk '{print $1}')"  

  if [[ "${PROC}" == "nvim" ]]; then

    local ICON="$("${YQ_BIN}" '.icons.nvim' "${ICONS}")"
    local YQ_EXIT=$?
    (( $YQ_EXIT != 0 )) && fatal "yq failed with code $YQ_EXIT. Check yaml for path & syntax."

    local SOCKET="/tmp/$(ls /tmp | grep -E "${PANE_PID}")"
    local BUF_NAME="$( nvim --server ${SOCKET} --remote-expr 'expand("%:t")' )"
    
    if (( $DEBUG == 1 )); then 
      debug "PLUG_ROOT: ${PLUG_ROOT}"
      debug "SOCKET: ${SOCKET}"
      debug "PROC: ${PROC}"
      debug "ICONS: ${ICONS}"
      debug "ICON: ${ICON}"
      [[ -n "${BUF_NAME}" ]] && debug "BUF_NAME: ${BUF_NAME}" || fatal "bufname not found."  
    fi
    set_status "${BUF_NAME}"
  fi
}

set_status() {
  local STATUS="$1"
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
