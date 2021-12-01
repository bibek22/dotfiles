#!/bin/sh

player=$(playerctl metadata --format '{{lc(playerName)}}')
class=$(playerctl metadata --player=$player --format '{{lc(status)}}')


if [[ $player == "spotify" ]]; then
    swaymsg workspace number 22;
elif [[ $player == "mpd" ]]; then
    pgrep ncmpcpp && /home/bibek/.local/bin/windows_select_wayland "Ncmpcpp"  && exit 
    swaymsg workspace number 22; exec /home/bibek/.local/bin/runonce ncmpcpp ncmpcpp
    icon=""
elif [[ $player == "mpv" ]]; then
    /home/bibek/.local/bin/windows_select_wayland "mpv"
    icon=""
else
    swaymsg workspace number 9;
    icon=""
fi
