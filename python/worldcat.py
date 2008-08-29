#!/usr/bin/env python

import re, sys, urlparse, urllib2
from cultools import urlparams, bail


#
# Read URL from stdin and check it's OK
#
url = sys.stdin.readline().strip()

oclc_match = re.search(r'/oclc/([0-9]+)', url, re.IGNORECASE)

if not oclc_match:
	bail("Couldn't find an 'oclc' in the URL (" + url + ")")

oclc = oclc_match.group(1)

#
# Fetch the page - don't need it, but it validates the URL the user posted
#
try:
	page = urllib2.urlopen(url).read().strip()
except:
	bail("Couldn't fetch page (" + url + ")")


#
# Fetch the RIS file
#
ris_file_url = 'http://www.worldcat.org/oclc/' + oclc + '?page=endnote'

try:
	ris_file = urllib2.urlopen(ris_file_url).read()
except:
	bail("Could not fetch RIS file (" + ris_file_url + ")")

if not re.search(r'TY\s{1,4}-', ris_file):
	bail("RIS file doesn't have a 'TY -'")

print "begin_tsv"
print "linkout\tWCAT\t\t%s\t\t" % oclc
print "end_tsv"
print "begin_ris"
print "%s" % (ris_file)
print "end_ris"
print "status\tok"

