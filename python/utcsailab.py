#!/usr/bin/env python2.6

import sys, urllib, urllib2, urlparse, re, cookielib
import lxml.html, codecs

import socket

sys.stdout = codecs.getwriter('utf-8')(sys.stdout)

socket.setdefaulttimeout(15)

UTCSAI_URL = 'http://z.cs.utexas.edu/users/ai-lab/'

ERR_STR_PREFIX = 'status\terr\t'

#
# Fetch the page...
#

cookie_jar = cookielib.CookieJar()
handlers = []
handlers.append( urllib2.HTTPCookieProcessor(cookie_jar) )

opener=urllib2.build_opener(*handlers)
opener.addheaders = [("User-Agent", "CiteULike/1.0 +http://www.citeulike.org/")]
urllib2.install_opener(opener)

#
# Plugins get passed the URL as a line of stdin
#
url = sys.stdin.readline().strip()

url_query = urlparse.urlparse(url)[4]
#print "URL"
#print url_query
#print "END"

# can be id=1234567 or id=1234567.7654321
# The last number seems to be the only significant one, but this code (and historical
# articles) doesn't take that into account, so there are duplicates in the database :-(
#
utcsai_id_match = re.search('PubID=(\d+|[A-Za-z0-9_-]+)', url_query, re.IGNORECASE)

if not utcsai_id_match:
	#keyword_match = re.search('\?([A-Za-z0-9_-]+|NOT)', url_query, re.IGNORECASE)
	#print "Attempt"
	#print url_query
	#print keyword_match
	#print "End"
	#if not keyword_match:
	#	print ERR_STR_PREFIX + "Could not find id or keyword in URL (" + url + ")"
	#	sys.exit(1)
	#else: 
	#helper_url = UTCSAI_URL + 'helper.php?' + keyword_match.group(1)
	helper_url = UTCSAI_URL + 'helper.php?' + url_query
	utcsai_id = urllib2.urlopen(helper_url).read().strip(); 
else:
	utcsai_id = utcsai_id_match.group(1)

#print "ID"
#print utcsai_id
#print "END"

page_url = UTCSAI_URL + 'pub-view.php?PubID=' + utcsai_id

try:
	page = urllib2.urlopen(page_url).read();
except:
	print ERR_STR_PREFIX + "Could not fetch page (" + page_url + ")"
	sys.exit(1)

#
# The abstract is on a separate "page", called by JavaScript.   There is an alternative
# all-in-one page "&preflayout=flat" but it's not marked up very well and nigh impossible
# to get the abstract.
#
#

#abstract_match = re.search("tab_abstract.cfm([^\']+)", page, re.IGNORECASE)
#abs = []
#if abstract_match:
#	abstract_url = "http://portal.acm.org/%s" % abstract_match.group(0)
#	abstract_page = urllib2.urlopen(abstract_url).read();
#	root = lxml.html.fromstring(abstract_page)
#	for div in root:
#		t = div.text_content()
#		if t:
#			abs.append(t)

abstract_url = UTCSAI_URL + 'abstract.php?PubID=' + utcsai_id 
abstract_page = urllib2.urlopen(abstract_url).read();
abstract = abstract_page.strip()

#if len(abs) > 0:
#	abstract =  " ".join(abs).strip()
#else:
#	abstract = ""

#
# Look for the link to the BibTeX export
#

bibtex_url = UTCSAI_URL + 'bibtex.php?PubID=' + utcsai_id

#
# Fetch the BibTeX...
#
bibtex_url = re.sub("&amp;","&",bibtex_url)
#print "Fetching: %s " % bibtex_url

try:
	bibtex_page = urllib2.urlopen(bibtex_url).read();
except:
	print ERR_STR_PREFIX + "Could not fetch BibTeX page (" + bibtex_url + ")"
	sys.exit(1)

#
# UGH - BibTeX record comes back as part of an HTML page...
#
#bib_match = re.search('<pre id="[^"]+">(.+?)</pre>', bibtex_page, re.IGNORECASE | re.DOTALL)
#
#if not bib_match:
#	print bibtex_page
#	print ERR_STR_PREFIX + "Could not find BibTeX in page"
#	sys.exit(1)
#
#bibtex = bib_match.group(1).strip()
bibtex = bibtex_page

# Sometime dodgy key (with space).  Replace that.   This is a quick hack and only
# replaces a single space
bibtex = re.sub(r'^(@\w+{\S+)[ ](\S+)',r'\1\2',bibtex, re.MULTILINE)



#
# Output plugin results
#
print "begin_bibtex"
print bibtex
print "end_bibtex"

print "begin_tsv"

if abstract:
	print "abstract\t%s" % (abstract)

print "linkout\tUTCSAI\t%s\t\t\t" % (utcsai_id)

print "end_tsv"
print "status\tok"
