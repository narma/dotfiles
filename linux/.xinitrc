#!/bin/sh

xrdb -merge ~/.Xresources
twmnd >/dev/null 2>&1 &

# SETUP urxvtd daemon
urxvtd -q -f -o 
export RXVT_SOCKET=/home/narma/.urxvt/urxvtd-narma
export TERMINAL=urxvtc


xset -b # disable speaker

# exports global settings related to x, not shell
export CHROMIUM_USER_FLAGS="--purge-memory-button"

# use gpg-agent instead
# eval `ssh-agent`

exec i3 >/tmp/i3.log 2>&1
#exec notion > /tmp/notion.log 2>&1


