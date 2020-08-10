#!/usr/bin/env python
# Author: Bibek Gautam
# Date:   6th Aug 2020
# Parses color output by `wal` for dwm into the `path` file and produces a
# Xresource file at `target` which is then read in by a `xrdb` command
# And finally runs Super + F5 key to refresh the color in dwm bar.
import re
import os

path = "/home/bibek/.cache/wal/colors-wal-dwm.h"
target = "/home/bibek/.cache/wal/dwm.Xresources"

names = ["dwm.normfgcolor",
         "dwm.normbgcolor",
         "dwm.normbordercolor",
         "dwm.selfgcolor",
         "dwm.selbgcolor",
         "dwm.selbordercolor"]

with open(path) as file:
    data = file.read()

pattern = re.compile("#.{6}")
colors = pattern.findall(data)

out = open(target, "w+")
for i in range(len(names)):
    out.write(names[i] + ": " + colors[i] + "\n")
    # print(names[i] + ": " + colors[i] + "\n")
out.close()

os.system("xrdb -merge " + target)
os.system("xdotool key --clearmodifiers super+F5")
