#!/usr/bin/env bash

ROFI_CFG=$1

options="         Shutdown\n           Reboot\n󰤄          Suspend\n             Lock"

selected="$(echo -e "$options" | rofi -dmenu -font "JetBrainsMono Nerd Font 16" -l 4 -config "$ROFI_CFG" -theme-str 'window { width: 255px; } listview { scrollbar: false; } element-text { horizontal-align: 0.5; } inputbar { enabled: false; } mainbox { children: [listview]; }')"

case "$selected" in
    *Shutdown*)
        systemctl poweroff
        ;;
    *Reboot*)
        systemctl reboot
        ;;
    *Suspend*)
        systemctl suspend
        ;;
    *Lock*)
        i3lock --nofork -c 000000
        ;;
    *)
        ;;
esac
