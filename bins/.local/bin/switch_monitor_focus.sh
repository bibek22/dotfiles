#!/usr/bin/env bash

X_LOC=`xdotool getmouselocation | grep -Po "x:...." | grep -Po "\d*"`
if [ $X_LOC -lt 1367 ];then
    xdotool mousemove 2250 440
else
    xdotool mousemove 650 400
fi
