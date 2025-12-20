#!/usr/bin/env bash
local icons="$(tmux display -p "#{@LIB_ICON}" )"
echo "$icons"
