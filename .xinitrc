#!/bin/sh

export MY_HOSTNAME=""

userresources=$HOME/.Xresources

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

exec i3
