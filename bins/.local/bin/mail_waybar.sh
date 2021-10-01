#!/usr/bin/python
# This isn't too efficient
import sys
import glob


count = len(glob.glob("/home/bibek/.local/share/mail/*/INBOX/new/*"))
if count:
    count = '"<span foreground=\'green\'>' + " " + str(count) + '</span>"'
else:
    count = '""'

resp = '{ "text": "text", "alt": ' + count + '}'

sys.stdout.write(resp)
sys.stdout.flush()
sys.exit(0)
