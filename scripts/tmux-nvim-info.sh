#!/usr/bin/env bash
ICONS=$( tmux display -p "#{@LIB_ICON}" )
LOCAL_ROOT=$( tmux display -p "#{@LOCAL_ROOT}" )
SHARE="$( tmux show -gqv @CHER )"

## source helper functions from @CHER
source "$SHARE/dump.fun"
source "$SHARE/fatal.fun"

## check for yq
YQ='/usr/bin/yq'
if ! command -v "${YQ}" &> /dev/null; then
  fatal "yq executable not found at ${YQ}."
fi

main() 
{
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
    local ICON="$("${YQ}" ".icons.apps.${PARENT_PROC}" "${ICONS}")"
    local EXIT=$? && (( ${EXIT} != 0 )) && fatal "yq failed with code ${EXIT}. Check yaml for path & syntax."
    local BUF_NAME="${PARENT_PROC}"
    SOCKET="none"
  fi

  dump "LOCAL_ROOT:$LOCAL_ROOT"
  dump "PANE_PID:${PANE_PID}"
  dump "SOCKET:${SOCKET}"
  dump "CHILD_PROC:${PARENT_PROC}"
  dump "PARENT_PROC:${PARENT_PROC}"
  dump "ICONS:~/${ICONS#*/home*$USER/}"
  dump "ICON:${ICON}"
  dump "STATUS:${STATUS}"

  ## set status bar 
  tmux set -g @nvim-info-unit "#[fg=#{@Dark4}]#{@TriangleL}#[bg=#{@Light0_S}]#[reverse]${STATUS}#[bg=default]#[noreverse]#{@TriangleRInverse}"
}


main
