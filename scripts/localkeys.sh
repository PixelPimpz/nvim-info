#!/usr/bin/env bash
main {
  for keybind in "$( tmux list-keys | grep 'next-window' | grep -iv 'wheel' )"; do
    echo "$keybind" | awk '{printf "bind-key %-4s %s \\; %s\n", $4, $5, "source-file ~/.tmux.conf" }' >> ~/temp-tmux.log
  done
}

main

