#!/bin/bash

# Show battery percentage and status in i3bar.
# Change the color with the percentage and display low battery notifications.
# Clicking on the icon shows amount of time remaining/time until charged.

HOST=$(hostname)


if [[ "$HOST" == "Arch" ]] || [[ "$HOST" == "arch-win" ]]; then
        POWER=$(acpi -b)
        if [[ "$POWER" == "" ]]; then
                exit 1
        fi
        STATE=$(echo $POWER | cut -d : -f 2              \
                            | cut -d , -f 1              \
                            | tr '[:upper:]' '[:lower:]' \
                            | sed 's/[[:space:]]//g')
        PERCENTAGE=$(echo $POWER | grep -o '[^ ]*%' | grep -o '[0-9]*')
        REMAINING=$(acpi -b | cut -d % -f 2 | cut -d , -f 2)
elif [[ "$HOST" == "localhost" ]]; then
        STATE=`upower -i $(upower -e | sed -n "1p") | \
               grep "state" | cut -d : -f2 | tr -d ' '`
        PERCENTAGE=`upower -i $(upower -e | sed -n "1p") | \
                    grep "percentage" | grep -o '[0-9]*'`
        REMAINING=`upower -i $(upower -e | sed -n "1p") | \
                   grep "time to"`
else
        exit 1
fi

if [[ "$STATE" == "charging" ]]; then
        COLOR=""
        if [[ "$PERCENTAGE" -lt "15" ]]; then
                SYMBOL=""
        elif [[ "$PERCENTAGE" -lt "30" ]]; then
                SYMBOL=""
        elif [[ "$PERCENTAGE" -lt "45" ]]; then
                SYMBOL=""
        elif [[ "$PERCENTAGE" -lt "60" ]]; then
                SYMBOL=""
        elif [[ "$PERCENTAGE" -lt "75" ]]; then
                SYMBOL=""
        elif [[ "$PERCENTAGE" -lt "90" ]]; then
                SYMBOL=""
        else
                SYMBOL=""
        fi
elif [[ "$STATE" == "discharging" ]]; then
        if [[ "$PERCENTAGE" -lt "10" ]]; then
                SYMBOL=""
                COLOR="#F2777A"
                notify-send -t 1000 -i ~/.i3/low-battery.png 'Battery Low'
        elif [[ "$PERCENTAGE" -lt "20" ]]; then
                SYMBOL=""
                COLOR="#F2777A"
        elif [[ "$PERCENTAGE" -lt "40" ]]; then
                SYMBOL=""
                COLOR="#F99157"
        elif [[ "$PERCENTAGE" -lt "50" ]]; then
                SYMBOL=""
                COLOR="#FFCC66"
        elif [[ "$PERCENTAGE" -lt "90" ]]; then
                SYMBOL=""
        else
                SYMBOL=""
        fi
elif [[ "$STATE" == "full" ]] | [[ "$STATE" == "unknown" ]]; then
        SYMBOL=""
        COLOR=""
else
        SYMBOL=""
        COLOR=""
fi

echo $SYMBOL$PERCENTAGE%
echo $SYMBOL$PERCENTAGE%
echo $COLOR

if [[ $BLOCK_BUTTON == '3' ]]; then
        notify-send "$REMAINING" -t 2000
fi
