#!/bin/sh

player=$(playerctl metadata --format '{{lc(playerName)}}')
class=$(playerctl metadata --player=$player --format '{{lc(status)}}')
if [[ $player == "spotify" ]]; then
    icon=""
elif [[ $player == "mpd" ]]; then
    icon=""
elif [[ $player == "mpv" ]]; then
    icon=""
elif [[ $player == "chromium" ]]; then
    icon=""
else
    icon=""
fi

if [[ $class == "playing" ]]; then
    if [[ $player == "firefox" ]]; then
      info=$(playerctl metadata --player=$player --format '{{title}}')
  else
      info=$(playerctl metadata --player=$player --format '{{artist}} - {{title}}')
    fi
  
  info=$(echo $info | cut -c1-39  | sed -E "s/[[:alnum:]_'-]+/\u&/g");
 
  text=$icon" "$info
elif [[ $class == "paused" ]]; then
  text=$icon
else # stopped
  text=""
fi

echo -e "{\"text\":\""$text"\", \"class\":\""$class"\"}"
