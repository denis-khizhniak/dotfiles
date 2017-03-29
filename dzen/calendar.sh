#!/bin/bash
#
# Simple calendar for dzen2
#

FONT="-*-monospace-*-*-*-*-*-*-*-*-*-*-*-*"

echo "$(cal -wm)" | dzen2 -p -x "500" -y "30" -w "240" -l 7 -sa 'c' -ta 'c' -fn "$FONT"\
                    -title-name 'popup_calendar' -e 'onstart=uncollapse;button1=exit;button3=exit'
