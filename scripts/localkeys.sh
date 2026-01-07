#!/usr/bin/env bash
main() {
  for orig in "$( tmux list-keys | grep 'next-window' | grep -iv 'wheel' )"; do
    local keystr="$( awk '{print $4}' <<< $orig )"
    local cmdstr="$( awk '{print $5}' <<< $orig )"
    echo -n "$keystr $cmdstr" >> ~/temp-tmux.log
  done
}
main

