#!/bin/bash

echo ""

export minute = 1000 * 60

for ((number=0;number < $1;number++))
{
  sleep 1000
  notify-send --expire-time=1000 'Work ['$(pamixer --get-volume)'%]'
}

exit 0
