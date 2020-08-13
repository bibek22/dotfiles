#!/usr/bin/env python
# Author: Bibek Gautam
# Date:   6th Aug 2020
# Parses color output by `wal` for dwm into the `path` file and produces a
# Xresource file at `target` which is then read in by a `xrdb` command
# And finally runs Super + F5 key to refresh the color in dwm bar.
import re
import os
from colorsys import rgb_to_hsv, hsv_to_rgb

path = "/home/bibek/.cache/wal/colors-wal-dwm.h"
target = "/home/bibek/.cache/wal/dwm.Xresources"

names = [
    "dwm.normfgcolor", "dwm.normbgcolor", "dwm.normbordercolor",
    "dwm.selfgcolor", "dwm.selbgcolor", "dwm.selbordercolor"
]

with open(path) as file:
    data = file.read()

pattern = re.compile("#.{6}")
colors = pattern.findall(data)
colors[5] = colors[4]
colors[2] = colors[1]
colors[3] = colors[1]

#  rgb = colors[4].lstrip('#')
#  rgb = tuple(int(rgb[i:i+2], 16) for i in (0, 2, 4))
#  h, s, v = rgb_to_hsv(*rgb)
#  s_more = s * 1.5 ; s_less = s*0.6
#  rgB = "#" + "".join(str(hex(int(i))[2:]) for i in hsv_to_rgb(h,s_more,v))
#  rgb = "#" + "".join(str(hex(int(i))[2:]) for i in hsv_to_rgb(h,s_less,v))
#  colors[5] = rgB
#  colors[2] = rgB

out = open(target, "w+")
for i in range(len(names)):
    out.write(names[i] + ": " + colors[i] + "\n")
    # print(names[i] + ": " + colors[i] + "\n")
out.close()

os.system("xrdb -merge " + target)
os.system("xdotool key --clearmodifiers super+F5")
