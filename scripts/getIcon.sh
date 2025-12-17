#!/usr/bin/env bash
THIS=$0
tmux display "${THIS##*/} running."
tmux display -p "${LIB_ICON}"
