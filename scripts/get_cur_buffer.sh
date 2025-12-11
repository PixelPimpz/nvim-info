#!/usr/bin/env bash
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PLUG_ROOT="${CURRENT_DIR%/*}"
ICONS="${PLUG_ROOT}/lib/app-icons.yaml"
YQ_BIN='/usr/bin/yq'

DEBUG=$1

main() {
  if ! command -v "${YQ_BIN}" &> /dev/null; then
    fatal "yq executable not found at ${YQ_BIN}."
  fi
  
  local PANE_PID="$(tmux display -p "#{pane_pid}")"
  local PROC="$(ps -h --ppid "${PANE_PID}" -o cmd | head -n -1 | awk '{print $1}')"  

  if [[ "${PROC}" == "nvim" ]]; then

    local ICON="$("${YQ_BIN}" '.icons.apps.nvim' "${ICONS}")"
    local YQ_EXIT=$?
    (( $YQ_EXIT != 0 )) && fatal "yq failed with code $YQ_EXIT. Check yaml for path & syntax."

    local SOCKET="/tmp/$(ls /tmp | grep -E "${PANE_PID}")"
    local BUF_NAME="$( nvim --server ${SOCKET} --remote-expr 'expand("%:t")' )"
  else
    local BUF_NAME="$(ps -q ${PANE_PID}-o comm= )"
  fi
  if (( $DEBUG == 1 )); then 
    debug "PLUG_ROOT:~/${PLUG_ROOT#*/home*$USER/}"
    debug "SOCKET:${SOCKET}"
    debug "PROC:${PROC}"
    debug "ICONS:~/${ICONS#*/home*$USER/}"
    debug "ICON:${ICON}"
    debug "BUF_NAME:${BUF_NAME}"
  fi
  set_status "${ICON} ${BUF_NAME}"
}

set_status() {
  local STATUS="$1"
  tmux set -g @CurrentData "${STATUS}"
  tmux set -g @Current "#[fg=#{@Dark2},bg=#{@Dark0}]#{@TriangleL}#[fg=#{@Light2},bg=#{@Dark2}] #{@CurrentData} #[fg=#{@Dark2},bg=#{@Dark0}]#{@TriangleRInverse}"
  tmux set -g status-right "#{E:@Current}#{T:@DateTime}"
  tmux set -g status-right-length 0
}

debug() {
  [[ "$1" ]] && local OUT="${1}" || local OUT="no data"
  local FMT=' %10s | %-56s '
  printf "${FMT}\n" "${OUT%:*}" "${OUT#*:}"
}

fatal() {
  [[ -n "$1" ]] && local E="unknown error" || local E="$1"
  printf 'ERROR: %s\n' "$E" >&2
  exit 1
}

main
