#!/bin/bash
# Script Credit: https://www.youtube.com/watch?v=c8v84LRTeUw
# Requirements: redshift, notify-send (libnotify)

# check if process is running ( 0 = off, 1 = on )
STATUS="$(ps -ef | grep -w '[r]edshift' | wc -l)"
# if off then turn on
if [[ "${STATUS}" == 0 ]]; then
#  notify-send -t 1 --icon=info "RedShift" "On"
  redshift >/dev/null 2>&1 & disown
# else if on then turn off
elif [[ "${STATUS}" == 1 ]]; then
#  notify-send -t 1 --icon=info "RedShift" "Off"
  redshift -x && killall redshift
fi
