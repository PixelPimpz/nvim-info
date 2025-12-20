#!/usr/bin/env bash
local icons="$(tmux display "#{@LIB_ICON}" )"
tmux display -p "#{@LIB_ICON}"
printf 'icons: %s', "test-string"
