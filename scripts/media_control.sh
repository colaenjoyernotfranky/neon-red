#!/bin/bash

NOTIFICATION_ID=9999
PACTL_ARGUMENT=$1
BAR_SIZE=10
MAX_NOTIFICATION_LENGTH=45

if [ -n "$PACTL_ARGUMENT" ]; then
    if [ "$PACTL_ARGUMENT" = "next" ]; then
        playerctl next
        sleep 1
    elif [ "$PACTL_ARGUMENT" = "previous" ]; then
        playerctl previous
        sleep 1
    elif [ "$PACTL_ARGUMENT" = "mute" ]; then
        pactl set-sink-mute @DEFAULT_SINK@ toggle
    else
        pactl set-sink-volume @DEFAULT_SINK@ "$PACTL_ARGUMENT"
    fi
else
    playerctl play-pause
fi

current_track_info="$(playerctl metadata --format '{{ artist }} - {{ title }}' 2>/dev/null)"

if [ ${#current_track_info} -gt $MAX_NOTIFICATION_LENGTH ]; then
    current_track_info="${current_track_info:0:$((MAX_NOTIFICATION_LENGTH-3))}..."
    printf current_track_info
fi

current_volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+%' | head -n1 | tr -d '%')
is_muted=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')

if [ "$current_volume" -gt 100 ]; then
    current_volume=100
    pactl set-sink-volume @DEFAULT_SINK@ 100%
fi

filled_size=$(( (current_volume * BAR_SIZE) / 100 ))
empty_size=$(( BAR_SIZE - filled_size ))

if [ "$filled_size" -gt 0 ]; then
    filled=$(printf '█ %.0s' $(seq 1 $filled_size))
else
    filled=""
fi

if [ "$empty_size" -gt 0 ]; then
    empty=$(printf '    %.0s' $(seq 1 "$empty_size"))
else
    empty=""
fi

bar=" $filled$empty"

status="$(playerctl status 2>/dev/null)"
cover_url="$(playerctl metadata mpris:artUrl 2>/dev/null)"

if [ -z "$cover_url" ]; then
    cover_url="/usr/share/icons/Adwaita/48x48/devices/audio-card.png"
fi

if [ "$is_muted" = "no" ]; then
    if [ "$status" = "Playing" ]; then
            volume_bar="$(echo -e "  $bar")"
    elif [ "$status" = "Paused" ]; then
            volume_bar="$(echo -e "  $bar")"
    fi
else
    volume_bar="$(echo -e "  $bar")"
fi

notify-send -r "$NOTIFICATION_ID" --icon="$cover_url" "$(echo -e "$current_track_info")" "$volume_bar"
