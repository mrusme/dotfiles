#!/bin/sh

cmd=$1

if [[ "$cmd" == "set" ]]
then
  governor=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors | tr " " "\n" | grep -v '^$' | wofi --dmenu)
  if [[ "$governor" != "" ]]
  then
    sudo cpupower frequency-set -g "$governor"
  fi
elif [[ "$cmd" == "get" ]]
then
  cpupower frequency-info -p | tail -n -3
fi

