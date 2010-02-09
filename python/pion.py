#!/usr/bin/env python

import re, sys, urlparse, urllib2
from cultools import urlparams, bail
import socket

socket.setdefaulttimeout(15)


#
# Read URL from stdin and check it's OK
#
url = sys.stdin.readline().strip()

url_host = urlparse.urlparse(url)[1]

if url_host in [ 'www.envplan.com', 'www.perceptionweb.com' ]:
	linkout = 'PION'
else:
	bail("Unrecognised site: " + url_host + " - does the plugin need updating")

try:
	id = urlparams(url)["id"]
except:
	bail("Couldn't find an 'id' field in the URL (" + url + ")")

#
# Fetch the page
#
try:
	page = urllib2.urlopen(url).read().strip()
except:
	bail("Couldn't fetch page (" + url + ")")


#
# Fetch the RIS file
#
ris_file_url = 'http://' + url_host + "/ris.cgi?id=" + id

try:
	ris_file = urllib2.urlopen(ris_file_url).read()
except:
	bail("Could not fetch RIS file (" + ris_file_url + ")")

if not re.search(r'TY\s{1,4}-', ris_file):
	bail("RIS file doesn't have a 'TY -'")

#
# DOI is in the page, but not the RIS
#
doi_match = re.search(r'doi:(10\.[^/]+/[^\s<]+)', page,  re.IGNORECASE)

if doi_match:
    doi = doi_match.group(1)
else:
    doi = ''

print "begin_tsv"

if doi:
	print "linkout\tDOI\t\t%s\t\t" % doi

print "linkout\t%s\t\t%s\t\t%s" % (linkout, url_host, id)
print "end_tsv"
print "begin_ris"
print "%s" % (ris_file)
print "end_ris"
print "status\tok"

