#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap


# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK


# Take a break every 20 mins !
while true ;
do
  while pgrep slock; do
    sleep 30s # pause on screen lock
  done
  sleep 25m
  notify-send "minute break"
  # sleep 5; slock 
done &


unclutter &
xset r rate 250 40 &

# Notification daemon
dunst &

numlockx &

# for autolock
xautolock -time 10 -locker "slock" -detectsleep -notify 5 -notifier "notify-send 'screenlock in 5sec'" -corners 0-+0 &

if [ ! `pgrep mpd` ]; then
    mpd
fi

# set background
# ~/.fehbg &

# if [ ! `pgrep batter_notify` ]; then
#     /usr/local/bin/batter_notify &
# fi

compton &
# nm-applet &
sleep 1 && st &
sleep 1 && redshift &
sleep 3 && pcmanfm -d &

# Restore colorscheme (second line below does it in dwmbar)
wal -R
xrdb -merge /home/bibek/.cache/wal/dwm.Xresources

/usr/local/bin/dwmbar &

LOC=/home/bibek/build/dwm/
while true; do
      # sed "s/Urg/d" -i /home/bibek/.cache/wal/colors-wal-dwm.h
      cd $LOC
      make
      cd ~
      /$LOC/dwm
done
