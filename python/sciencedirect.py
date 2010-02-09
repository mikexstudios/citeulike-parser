#!/usr/bin/env python2.6
# NOTE THIS NEEDS 2.6 as parser breaks with 2.5 :-)
import warnings
warnings.simplefilter("ignore",DeprecationWarning)

import os, sys, re, urllib2, cookielib, string
from urllib import urlencode
from urllib2 import urlopen
from copy import copy
import BeautifulSoup
import htmlentitydefs
import html5lib
from html5lib import treebuilders

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



#
# Strip off any institutional proxies we find
#
def canon_url(url):
#	print "xxxxx url = %s" % url
	m = re.match(r'http://[^/]*sciencedirect.com[^/]*/(science(\?_ob|/article).*$)', url)
	if not m:
		raise ParseException, "bad source url"
	return "http://www.sciencedirect.com/" + m.group(1)


#
# Make up crossref metadata URL (just need the DOI)
#
def crossref_xml_url(doi):
	url = "http://www.crossref.org/openurl/?id=doi:" + doi
	url += "&noredirect=true"

	key_file = os.environ.get("HOME") + "/.crossref-key"
	if os.path.exists(key_file):
		f = open(key_file)
		key = f.read().strip()
		f.close()
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

	parser = html5lib.HTMLParser(tree=treebuilders.getTreeBuilder("beautifulsoup"))
	soup = parser.parse(page)
#	soup = BeautifulSoup.BeautifulSoup(page)
	for div in soup.findAll('div',attrs={'class':'articleText'}):
		h3 = div.find('h3',{'class':'h3'})
		if h3:
			val = h3.contents[0]
			if string.lower(val) in ('abstract'):
				for p in h3.findNextSiblings('p'):
					for t in p.findAll(text=True):
						abs.append(t)
				break

	abstract = ' '.join(abs);

	abstract = re.sub('\n+',' ',abstract)
	return unescape(abstract)


#
# Just try to fetch the metadata from crossref
#
def handle(url):

	page = urlopen(canon_url(url)).read()

	m = re.search(r'<a href="http://dx.doi.org/([^"]+)"', page)

	# this page might requires a login.  Luckily there seems to be a
	# link "View Abstract" which can take us to a page we can read
	if not m:
		parser = html5lib.HTMLParser(tree=treebuilders.getTreeBuilder("beautifulsoup"))
		soup = parser.parse(page)
#		soup = BeautifulSoup.BeautifulSoup(page)
		for link in soup.findAll('a'):
			if link.string and string.lower(link.string) in ('view abstract'):
				page = urlopen(canon_url("http://www.sciencedirect.com" + link['href'])).read()
				m = re.search(r'<a href="http://dx.doi.org/([^"]+)"', page)
				break

	if not m:
		raise ParseException, "Cannot find DOI in page"

	doi = m.group(1)

	# if not re.search(r'^10[.](1016|1006|1053)/',doi):
	#	raise ParseException, "Cannot find an Elsevier DOI (10.1006, 10.1016, 10.1053) DOI"

	xml_url  = crossref_xml_url(doi)
	xml_page = urlopen(xml_url).read()


	xml_page = xml_page.decode('utf-8')

	# Get rid of extraneous "stars" \u2606.   Sometimes at end of title (hopefully
	# they're never meant to be "real" elsewhere...)
	xml_page = xml_page.replace(u'\u2606',' ')
	#\xe2\x98\x86



	m = re.search("DOI not found in CrossRef", xml_page)
	if m:
		raise ParseException, "Unable to locate that DOI (%s) in crossref" % doi


	#
	# Emergency bodge to fix completely toileted XML from crossref
	#
	#m = re.search("(<doi_record>.*</doi_record>)", xml_page, re.S)
	#if not m:
#		raise ParseException, "Unable to extract metadata - malformed XML"

#	xml_page = m.group(1)


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
# 	urllib2.ProxyHandler({"http":"http://quimby.smithersbet.com:3128"})

	url = sys.stdin.readline().strip()
	try:
		for line in handle(url):
			print line.encode("utf-8")
	except Exception, e:
		import traceback
		line = traceback.tb_lineno(sys.exc_info()[2])
		print "\t".join(["status", "error", "There was an internal error processing this request. Please report this to bugs@citeulike.org quoting error code %d." % line])
		raise

