/bin/env bash
tmux set-hook -g pane-focus-in[0] 'run "#{@PLUG_ROOT}/scripts/get_cur_buffer.sh'
tmux set-hook -g session-window-changed[0] 'display -p "Session-window-changed."'
tmux set-hook -g session-window-changed[1] 'run "#{@PLUG_ROOT}/scripts/get_cur_buffer.sh'
tmux set-hook -g after-new-window[1] 'run "#{@PLUG_ROOT}/scripts/get_cur_buffer.sh'
tmux set-hook -g after-refresh-client[11] 'display -p "${TMUX_ROOT}/tmux.conf reloaded'
