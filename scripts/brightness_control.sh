#!/bin/sh

NOTIFICATION_ID=9999
BRIGHTNESSCTL_ARGUMENT=$1
BAR_SIZE=15
MAX_NOTIFICATION_LENGTH=45

if [ -n "$BRIGHTNESSCTL_ARGUMENT" ]; then
    if [ "$BRIGHTNESSCTL_ARGUMENT" = "up" ]; then
        brightnessctl set +10%
    elif [ "$BRIGHTNESSCTL_ARGUMENT" = "down" ]; then
        brightnessctl set 10%-
    fi
else
    exit 0
fi

brightness_in_percent=$(( ("$(brightnessctl get)" * 100) / 255 ))

if [ -n "$filled_size" ]; then
    filled_size=0
else
    filled_size=$(( (brightness_in_percent * BAR_SIZE) / 100 ))
fi

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

bar="󰖨  $filled$empty"

notify-send -r "$NOTIFICATION_ID" "$bar"
