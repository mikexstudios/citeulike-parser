#!/usr/bin/env python

import re, sys, urlparse, urllib2
from cultools import urlparams, bail

#
# Read URL from stdin and check it's OK
#
url = sys.stdin.readline().strip()

#
# Fetch the page - don't need it, but it validates the URL the user posted
#
try:
	page = urllib2.urlopen(url).read().strip()
except:
	bail("Couldn't fetch page (" + url + ")")

isbn = ""

m = re.search(r'isbn=(\d+)', page)
if m:
	isbn = m.group(1)
else:
	bail("Couldn't find an ISBN in that page")

print "status\tredirect\thttp://www.worldcat.org/isbn/%s" % isbn

