#!/usr/bin/env bash
PLUG_ROOT="$(tmux display -p "#{@PLUG_ROOT}")"
ICONS=$( tmux display -p "#{@LIB_ICON}" )
YQBIN='/usr/bin/yq'

if ! command -v "${YQBIN}" &> /dev/null; then
  fatal "yq executable not found at ${YQBIN}."
fi
DEBUG=$1

main() {
  local PANE_PID="$(tmux display -p "#{pane_pid}")"
  local SOCKET="/tmp/$(ls /tmp | grep -E "${PANE_PID}")"

  if [[ "${SOCKET}" =~ ${PANE_PID} ]]; then # /tmp/nvim-XXXXX = nvim ... /tmp/ = no nvim socket 
    local PROC="$(ps -h --ppid "${PANE_PID}" -o cmd | head  -1 | awk '{print $1}')"  
    local ICON="$( yq e ".icons.apps.${PROC}" $ICONS )"
    local EXIT=$? && (( ${EXIT} != 0 )) && fatal "yq failed with code ${EXIT}. Check yaml for path & syntax."
    local BUF_NAME="$( nvim --server ${SOCKET} --remote-expr 'expand("%:t")' )"
  else
    local PROC="$( ps -q ${PANE_PID} -o comm= )"
    local ICON="$("${YQBIN}" ".icons.apps.${PROC}" "${ICONS}")"
    local EXIT=$? && (( ${EXIT} != 0 )) && fatal "yq failed with code ${EXIT}. Check yaml for path & syntax."
    local BUF_NAME="${PROC}"
    SOCKET="none"
  fi

  if (( $DEBUG == 1 )); then 
    debug "PLUG_ROOT:~/${PLUG_ROOT#*/home*$USER/}"
    debug "PANE_PID:${PANE_PID}"
    debug "SOCKET:${SOCKET}"
    debug "PROC:${PROC}"
    debug "ICONS:~/${ICONS#*/home*$USER/}"
    debug "ICON:${ICON}"
    [[ -n "${BUF_NAME}" ]] && debug "BUF_NAME:${BUF_NAME}" || fatal "bufname not found."  
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
