#!/usr/bin/python
# takes input from sdvc | stripends and gives output ready for notification
import sys
import re

inp = sys.stdin.read()
pat = re.compile("([adjvn]* \d?: )")
ipat = re.compile("(\d: )")
match = pat.split(inp)[1:]

for i in range(len(match)//2):
    pos = match[2*i]
    sys.stdout.write("<i>" + pos + "</i>")

    meat = match[2*i+1]
    #  print(meat)
    pmatch = ipat.split(meat)
    if len(pmatch):
        till = min(3, len(pmatch))
        for entry in pmatch[:till]:
            sys.stdout.write(entry.replace("\n", " ") + "\n")
    else:
        sys.stdout.write(meat.replace("\n", " ") + "\n")
