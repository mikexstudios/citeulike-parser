#!/sw/bin/python2.4
#!/usr/bin/env python

import sys, urllib, urllib2, urlparse, cgi, re, mechanize, codecs
from BeautifulSoup import BeautifulSoup

ACM_URL = 'http://portal.acm.org/'

ERR_STR_PREFIX = 'status\terr\t'

#
# Plugins get passed the URL as a line of stdin
#
url = sys.stdin.readline().strip()

url_query = urlparse.urlparse(url)[4]

acm_id_match = re.search('id=(\d+([.]\d+)?)', url_query, re.IGNORECASE)

if not acm_id_match:
	print ERR_STR_PREFIX + "Could not find id in URL (" + url + ")"
	sys.exit(1)

acm_id = acm_id_match.group(1)


#
# Fetch the page...
#
page_url = ACM_URL + 'citation.cfm?id=' + acm_id

try:
	page = urllib2.urlopen(page_url).read();
except:
	print ERR_STR_PREFIX + "Could not fetch page (" + page_url + ")"
	sys.exit(1)


#
# Now try to extract the abstract from the page itself - it's not in the BibTeX
#
# Abstract appears to be inside <p class="abstract">...</p>, but within that there's all sorts
# of HTML markup that we need to strip. Also -- UGH, they should know better -- the HTML is malformed, so the
# abstract is sometimes presented like this: <p class="abstract"><p>....</p></p> : YOU CAN'T NEST <p> tags
#
page = re.sub('<p class="abstract">\s+<p>', '<p class="abstract">', page)

soup = BeautifulSoup(page)

abstract = soup.find("p", "abstract").findAll(text=True)

abstract = u' '.join(abstract)
abstract = re.sub('\n+', ' ', abstract).strip()


#
# Look for the link to the BibTeX export
#
bibtex_match = re.search("window.open[(]'([^\']+)',", page, re.IGNORECASE)

if not bibtex_match:
	print ERR_STR_PREFIX + "Could not find BibTeX export link (popBibTex.cfm...) in page"
	sys.exit(1)

bibtex_url = ACM_URL + bibtex_match.group(1)

#
# Fetch the BibTeX...
#
try:
	bibtex_page = urllib2.urlopen(bibtex_url).read();
except:
	print ERR_STR_PREFIX + "Could not fetch BibTeX page (" + bibtex_url + ")"
	sys.exit(1)

#
# UGH - BibTeX record comes back as part of an HTML page...
#
bib_match = re.search('<pre id="[\d.]+">(.+?)</pre>', bibtex_page, re.IGNORECASE | re.DOTALL)

if not bib_match:
	print ERR_STR_PREFIX + "Could not find BibTeX in page"
	sys.exit(1)

bibtex = bib_match.group(1).strip()


#
# Look for the DOI in the bibtex
#
doi_match = re.search('doi\s*=\s*\{http://[^/]+/(10\.[^/]+/.+?)\}', bibtex,  re.IGNORECASE)

if doi_match:
	doi = doi_match.group(1)
else:
	doi = ''


#
# Output plugin results
#
print "begin_bibtex"
print bibtex
print "end_bibtex"

print "begin_tsv"

if abstract:
	print "abstract\t%s" % (abstract)

print "linkout\tACM\t%s\t\t\t" % (acm_id)

if doi:
	print "linkout\tDOI\t\t%s\t\t" % (doi)

print "end_tsv"
print "status\tok"
