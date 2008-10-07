#!/usr/bin/env python

import os, sys, re, urllib2, cookielib, string
from urllib import urlencode
from urllib2 import urlopen
from copy import copy
import BeautifulSoup


class ParseException(Exception):
	pass


#
# Strip off any institutional proxies we find
#
def canon_url(url):
	m = re.match(r'http://[^/]*sciencedirect.com[^/]*/(science(\?_ob|/article).*$)', url)
	if not m:
		raise ParseException, "bad source url"
	return "http://www.sciencedirect.com/" + m.group(1)


#
# Make up crossref metadata URL (just need the DOI)
#
def crossref_xml_url(doi):

	f = open(os.environ.get("HOME") + "/.crossref-key");
	key = f.read().strip()
	f.close()

	url = "http://www.crossref.org/openurl/?id=doi:" + doi
	url += "&noredirect=true"
	url += "&pid=" + key
	url += "&format=unixref"

	return url


#
# Try, by foul trickery, to get an abstract
# We're looking for HTML like this:
#   <div class="articleText" style="display: inline;">
#       <h3 class="h3">Abstract</h3>
#       <p>An instrumented indentation technique...
#
def scrape_abstract(page):

	abs = []

	soup = BeautifulSoup.BeautifulSoup(page)

	for div in soup.findAll('div',attrs={'class':'articleText'}):
		h3 = div.find('h3',{'class':'h3'})
		if h3:
			if string.lower(h3.string) in ('abstract'):
				for p in h3.findNextSiblings('p'):
					if p.string:
						abs.append(p.string)
				break

	abstract = ' '.join(abs);

	return re.sub('\n+',' ',abstract)


#
# Just try to fetch the metadata from crossref
#
def handle(url):
 
	page = urlopen(canon_url(url)).read()
	
	m = re.search(r'<a href="http://dx.doi.org/([^"]+)"', page)

	if not m:
		raise ParseException, "Cannot find DOI in page"

	doi = m.group(1)

	if not re.search(r'^10[.](1016|1006)/',doi):
		raise ParseException, "Cannot find an Elsevier DOI (10.1016, 10.1006) DOI"

	xml_url  = crossref_xml_url(doi)
	xml_page = urlopen(xml_url).read()

	yield "begin_crossref"
	yield xml_page
	yield "end_crossref"

	yield "begin_tsv"

	try:
		abstract = scrape_abstract(page)
	except:
		abstract = ''

	if abstract:
		print "abstract\t%s" % (abstract)

	yield "end_tsv"

	yield "status\tok"

if __name__ == "__main__":

	cookie_jar = cookielib.CookieJar()

	handlers = []
	if "--debug" in sys.argv:
		handlers.append( urllib2.HTTPHandler(debuglevel=True) )
	handlers.append( urllib2.HTTPCookieProcessor(cookie_jar) )
	
	opener=urllib2.build_opener(*handlers)
	opener.addheaders = [
		("User-Agent", "CiteULike/1.0 +http://www.citeulike.org/"),
		]
	urllib2.install_opener(opener)

	url = sys.stdin.readline().strip()
	try:
		for line in handle(url):
			print line
	except Exception, e:
		import traceback
		line = traceback.tb_lineno(sys.exc_info()[2])
		print "\t".join(["status", "error", "There was an internal error processing this request. Please report this to bugs@citeulike.org quoting error code %d." % line])
		raise
		
