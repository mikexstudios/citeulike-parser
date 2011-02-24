#!/usr/bin/env python

import os, sys, re, urllib2, cookielib, string
from urllib import urlencode
from urllib2 import urlopen
from copy import copy
import BeautifulSoup
import htmlentitydefs
import socket

socket.setdefaulttimeout(15)


class ParseException(Exception):
	pass


##
# Removes HTML or XML character references and entities from a text string.
#
# @param text The HTML (or XML) source text.
# @return The plain text, as a Unicode string, if necessary.

def unescape(text):
    def fixup(m):
        text = m.group(0)
        if text[:2] == "&#":
            # character reference
            try:
                if text[:3] == "&#x":
                    return unichr(int(text[3:-1], 16))
                else:
                    return unichr(int(text[2:-1]))
            except ValueError:
                pass
        else:
            # named entity
            try:
                text = unichr(htmlentitydefs.name2codepoint[text[1:-1]])
            except KeyError:
                pass
        return text # leave as is
    return re.sub("&#?\w+;", fixup, text).encode('utf-8')

def meta(soup, key):
	el = soup.find("meta", {'name':key})
	if el:
		return el['content'];
	return None

def item(soup, entry, key):
	el = meta(soup, key)
	if el:
		print "%s\t%s" % (entry, el)

def handle(url):

	m = re.match(r'http://www\.jove.com/(?:index/Details\.stp|Details.php|details.stp)\?ID=(\d+)', url)
	if not m:
		raise ParseException, "URL not supported %s" % url
	wkey = m.group(1)

	ris_url = "http://www.jove.com/Resources/php/GetRIS.php?id=%s" % wkey

	ris = urlopen(ris_url).read()


	print "begin_tsv"
	print "linkout\tJOVE\t%s\t\t\t" % wkey
	print "type\tJOUR"
	print "end_tsv"
	print "begin_ris"
	print ris
	print "end_ris"
	print "status\tok"

# read url from std input
url = sys.stdin.readline()
# get rid of the newline at the end
url = url.strip()


try:
	handle(url)
except Exception, e:
	import traceback
	line = traceback.tb_lineno(sys.exc_info()[2])
	print "\t".join(["status", "error", "There was an internal error processing this request. Please report this to bugs@citeulike.org quoting error code %d." % line])
	raise

