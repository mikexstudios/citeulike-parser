#!/usr/bin/env python2.5

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
    return re.sub("&#?\w+;", fixup, text).encode('utf-8','ignore')

def meta(soup, key):
	el = soup.find("meta", {'name':key})
	if el:
		return el['content'].encode('utf-8','ignore')
	return None

def item(soup, entry, key):
	el = meta(soup, key)
	if el:
		print "%s\t%s" % (entry, el)

def handle(url):

	m = re.match(r'http://(?:www\.)?(jmedicalcasereports|casesjournal)\.com/(?:jmedicalcasereports|casesjournal)/article/view/(\d+)', url)
	if not m:
		raise ParseException, "URL not supported %s" % url
	site = m.group(1)
	wkey = m.group(2)

	url = "http://%s.com/%s/article/viewArticle/%s" % (site, site, wkey)

	page = urlopen(url).read()

	soup = BeautifulSoup.BeautifulSoup(page)

	head = soup.find("head")

	doi = meta(head, 'citation_doi')

	if not doi:
		raise ParseException, "Cannot find DOI"


	citation_pdf_url = meta(head, 'citation_pdf_url')
	pdf_key = ""
	if citation_pdf_url:
		m = re.search(r'(\d+)/(\d+)', citation_pdf_url)
		if m:
			pdf_key = m.group(2)

	print "begin_tsv"
	print "linkout\tDOI\t\t%s\t\t" % (doi)
	if site == "casesjournal":
		print "linkout\tCASES\t%s\t\t%s\t" % (wkey, pdf_key)
	elif site == "jmedicalcasereports":
		print "linkout\tJMEDC\t%s\t\t%s\t" % (wkey, pdf_key)
	else:
		raise ParseException, "Unknown journal %s" % site
	print "type\tJOUR"
	title = meta(head, "citation_title")
	if title:
		print "title\t%s" % unescape(title)
	item(head, "journal", "citation_journal_title")
	item(head, "issue", "citation_issue")
	item(head, "issn", "citation_issn")
	date = meta(head, 'citation_date')
	if date:
		m = re.match(r'(\d+)/(\d+)/(\d+)', date)
		if m:
			day = m.group(1)
			month = m.group(2)
			year = m.group(3)
			if year:
				print "year\t%s" % year
			if month:
				print "month\t%s" % month
			if day:
				print "day\t%s" % day

	# authors
	authors = head.findAll("meta", {"name":"DC.Creator.PersonalName"})
	if authors:
		for a in authors:
			print "author\t%s" % a['content'].encode('utf-8','ignore')

	abstract = meta(head,"DC.Description")
	if abstract:
		abstract = abstract.strip()
		abstract = re.sub(r'<[^>]+>','',abstract)
		abstract = unescape(abstract)
		abstract = abstract.strip()
		print "abstract\t%s" % abstract

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

