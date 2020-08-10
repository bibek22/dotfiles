#!/usr/bin/python
# takes input from sdvc and gives output ready for notification
import sys
import re

ret = sys.stdin.read()
striped = ret.split("\n")
for i in range(len(striped)): striped[i] = striped[i].strip()
striped = " ".join(striped[6:])

pat = re.compile("([adjvn]* \d: )")
last = ""
lines = [] ; possplit = []

for idx, line in enumerate(pat.split(striped)[1:]):

    if last:
        if len(last) > 3:
            blast = "<i>" + last[:-3] + "</i>\n" #italicize parts of speech tag
            lines.append(blast)
            last = last[-2:]
            possplit.append(len(lines)-1)
        lines.append(last +" " + line.strip())
        last = ""
    else: last = line.strip()

ret = ""
for i,val in enumerate(possplit):
    try:
        till =  val+3 if (possplit[i+1] > val + 3) else possplit[i+1]
    except:
        till = val+2
    ret += lines[val]
    ret += "\n".join(lines[val+1:till]) + "\n"

if not ret: ret = striped
sys.stdout.write(ret)
