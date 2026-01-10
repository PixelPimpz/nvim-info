#!/usr/bin/env bash
ICONS=$( tmux display -p "#{@LIB_ICON}" )
YQBIN='/usr/bin/yq'
PLUG_ROOT=$( tmux display -p "#{@PLUG_ROOT}" )
if ! command -v "${YQBIN}" &> /dev/null; then
  fatal "yq executable not found at ${YQBIN}."
fi

main() {
  local PANE_PID="$(tmux display -p "#{pane_pid}")"
  local SOCKET="/tmp/$(ls /tmp | grep -E "${PANE_PID}")"
  local CHILD_PROC="$(ps -o comm= --ppid "${PANE_PID}")"
  local PARENT_PROC="$(ps -q "${PANE_PID}" o comm=)"

  if [[ "${SOCKET}" =~ ${PANE_PID} ]]; then # /tmp/nvim-XXXXX = nvim ... /tmp/ = no nvim socket 
    local ICON="$( yq e ".icons.apps.${CHILD_PROC}" $ICONS )"
    local EXIT=$? && (( ${EXIT} != 0 )) && fatal "yq failed with code ${EXIT}. Check yaml for path & syntax."
    local BUF_NAME="$( nvim --server ${SOCKET} --remote-expr 'expand("%:t")' )"
    local STATUS="${ICON} ${BUF_NAME}"
  else
    local ICON="$("${YQBIN}" ".icons.apps.${PARENT_PROC}" "${ICONS}")"
    local EXIT=$? && (( ${EXIT} != 0 )) && fatal "yq failed with code ${EXIT}. Check yaml for path & syntax."
    local BUF_NAME="${PARENT_PROC}"
    SOCKET="none"
  fi

  debug "PLUG_ROOT:$PLUG_ROOT"
  debug "PANE_PID:${PANE_PID}"
  debug "SOCKET:${SOCKET}"
  debug "CHILD_PROC:${PARENT_PROC}"
  debug "PARENT_PROC:${PARENT_PROC}"
  debug "ICONS:~/${ICONS#*/home*$USER/}"
  debug "ICON:${ICON}"
  debug "STATUS:${STATUS}"

  ## set status bar 
  set_status "${ICON} ${BUF_NAME}"
}

set_status() {
  local STATUS="$1"
  tmux set -g @unit-style "fg=#{@Light2},bg=#{@Dark2}"
  tmux set -g @unit-style-end "fg=#{@Dark2},bg=#{@Dark0}"
  tmux set -g @CurrentData "${STATUS}"
  tmux set -g status-right-length 0
  tmux set -g status-right "#[#{E:@unit-style-end}]#{@TriangleL}#[#{E:@unit-style}] #{@CurrentData} #[#{E:@unit-style-end}]#{@TriangleRInverse}#{T:@DateTime}"
}

debug() {
  if (( $(tmux show -gqv @DEBUG) == 1 )); then
    [[ "$1" ]] && local OUT="${1}" || local OUT="no data"
    local FMT=' %10s | %-56s '
    printf "${FMT}\n" "${OUT%:*}" "${OUT#*:}"
  fi
}

fatal() {
  [[ -n "$1" ]] && local E="unknown error" || local E="$1"
  printf 'ERROR: %s\n' "$E" >&2
  exit 1
}

main
