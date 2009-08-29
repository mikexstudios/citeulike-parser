#!/usr/bin/env python

import re, sys, urlparse, urllib2
from cultools import urlparams, bail

#
# Read URL from stdin and check it's OK
#
url = sys.stdin.readline().strip()

oclc_match = re.search(r'/(oclc|isbn)/([0-9]+)', url, re.IGNORECASE)

if not oclc_match:
	bail("Couldn't find an 'oclc' in the URL (" + url + ")")

type = oclc_match.group(1)
id = oclc_match.group(2)

#
# Fetch the page - don't need it, but it validates the URL the user posted
#
try:
	page = urllib2.urlopen(url).read().strip()
except:
	bail("Couldn't fetch page (" + url + ")")

isbn = ""

if (type == "isbn"):
	isbn = id
	m = re.search(r'/oclc/(\d+)', page)
	if not m:
		bail("Couldn't locate OCLC on page "+url)
	oclc = m.group(1)
else:
	oclc = id
	m = re.search(r'rft.isbn=(\w+)', page)
	if m:
		isbn = m.group(1)

#
# Fetch the RIS file
#
ris_file_url = 'http://www.worldcat.org/oclc/%s?page=endnote' % oclc

try:
	ris_file = urllib2.urlopen(ris_file_url).read()
except:
	bail("Could not fetch RIS file (" + ris_file_url + ")")

print ris_file

if not re.search(r'TY\s{1,4}-', ris_file):
	bail("RIS file doesn't have a 'TY -'")


print "begin_tsv"
print "linkout\tWCAT\t\t%s\t\t" % oclc
print "linkout\tISBN\t\t%s\t\t" % isbn
if (isbn != ""):
	print "isbn\t%s" % isbn
print "end_tsv"
print "begin_ris"
print "%s" % (ris_file)
print "end_ris"
print "status\tok"

