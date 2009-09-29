#!/usr/bin/env python

import os, sys, re, urllib2, cookielib, string
from urllib import urlencode
from urllib2 import urlopen
from copy import copy
import BeautifulSoup
import htmlentitydefs

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

	MONTHS = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

	m = re.match(r'http://www\.agu\.org/pubs/crossref/([0-9.]+/[^/]+)\.shtml', url)
	if not m:
		raise ParseException, "URL not supported %s" % url
	wkey = m.group(1)

	page = urlopen(url).read()

	soup = BeautifulSoup.BeautifulSoup(page)

	head = soup.find("head")

	doi = meta(head, 'dc.identifier')

	if not doi:
		raise ParseException, "Cannot find DOI"
	m = re.match(r'doi:(.*)$', doi)
	if not m:
		raise ParseException, "Cannot find DOI"
	doi = m.group(1)

	print "begin_tsv"
	print "linkout\tDOI\t\t%s\t\t" % (doi)
	print "linkout\tAGU\t\t%s\t\t" % wkey
	print "type\tJOUR"
	title = meta(head, "dc.title")
	if title:
		print "title\t%s" % unescape(title)
	item(head, "journal", "prism.publicationName")
	item(head, "volume", "prism.volume")
	item(head, "issue", "prism.number")
	item(head, "start_page", "prism.startingPage")
	item(head, "end_page", "prism.endingPage")
	item(head, "issn", "prism.issn")
	date = meta(head, 'dc.date')
	if date:
		m = re.match(r'^(\d+)?\s?(January|February|March|April|May|June|July|August|September|October|November|December) (\d\d\d\d$)', date)
		if m:
			day = m.group(1)
			month = m.group(2)
			year = m.group(3)
			if year:
				print "year\t%s" % year
			if month:
				try:
					print "month\t%s" % (MONTHS.index(month)+1)
				except:
					pass
			if day:
				print "day\t%s" % day


	# authors
	authors = head.findAll("meta", {"name":"dc.creator"})
	if authors:
		for a in authors:
			print "author\t%s" % a['content']

	abstract = soup.find('div', {'class':'abstract'})
	if abstract:
		abs = abstract.renderContents().strip()
		abs = abs.replace(' xmlns=""','')
		abs = re.sub(r'<[^>]+>','',abs)
		abs = unescape(abs)
		print "abstract\t%s" % abs

	print "doi\t%s" % doi
	print "end_tsv"
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

