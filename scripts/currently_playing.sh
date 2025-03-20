#!/bin/bash

current_song=$(playerctl metadata --format '{{ artist }} - {{ title }}' 2>/dev/null)

if [ -n "$current_song" ]; then
    echo "$current_song"
else
    echo ""
fi

