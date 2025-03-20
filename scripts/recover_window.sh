#!/bin/bash

window_title=$1

if [ -z "$window_title" ]; then
  exit 0;
else
  window_ids=($(xdotool search --name "$window_title"))

  if [ ${#window_ids[@]} -eq 0 ]; then
    echo "No "$window_title" windows found."
    exit 1
  fi

  for id in "${window_ids[@]}"; do
    echo "Processing window ID: $id"
    xdotool windowmap "$id"
    xdotool windowraise "$id"
    xdotool windowactivate "$id"
  done
fi
