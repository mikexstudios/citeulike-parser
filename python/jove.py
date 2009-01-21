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

	m = re.match(r'http://www\.jove.com/index/Details\.stp\?ID=(\d+)', url)
	if not m:
		raise ParseException, "URL not supported %s" % url
	wkey = m.group(1)		

	page = urlopen(url).read()

	soup = BeautifulSoup.BeautifulSoup(page)

	head = soup.find("head")

	doi = meta(head, 'citation_doi')

	if not doi:
		raise ParseException, "Cannot find DOI"
			
	print "begin_tsv"
	print "linkout\tDOI\t\t%s\t\t" % (doi)
	print "linkout\tJOVE\t%s\t\t\t" % wkey
	print "type\tJOUR"
	title = meta(head, "citation_title")
	if title:
		print "title\t%s" % unescape(title)
	item(head, "journal", "citation_journal_title")
	item(head, "issue", "citation_issue")
	date = meta(head, 'citation_date')
	if date:
		m = re.match(r'(\d+)/(\d+)/(\d+)', date)
		if m:
			day = m.group(2)
			month = m.group(1)
			year = m.group(3)
			if year:
				print "year\t%s" % year
			if month:
				print "month\t%s" % month
			if day:
				print "day\t%s" % day
			

	# authors
	authors = head.findAll("meta", {"name":"dc.Contributor"})
	if authors:
		for a in authors:
			print "author\t%s" % a['content']

	abstract = soup.find('div', {'id':'C47_c1vzp1s1'})
	if abstract:
		abs = abstract.renderContents().strip()
#		abs = abs.replace(' xmlns=""','')
#		abs = re.sub(r'<[^>]+>','',abs)
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

