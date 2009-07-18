#!/usr/bin/env python

import sys, urllib, urllib2, urlparse, cgi, re, mechanize, codecs
from BeautifulSoup import BeautifulSoup

import html5lib
from html5lib import treebuilders

base = "http://www.biomedcentral.com"

url = "http://www.biomedcentral.com/browse/journals/"
# fetch the page the user is looking at
br = mechanize.Browser()
br.set_handle_robots(False)
br.open(url)

# get page (the meta tag lies about the encoding)
page = unicode(br.response().read())

#f = open("mydocument.html")
parser = html5lib.HTMLParser(tree=treebuilders.getTreeBuilder("beautifulsoup"))
soup = parser.parse(page)


# parse the HTML
#soup = BeautifulSoup(page)

img = soup.findAll('td', attrs={'class':'az-img'})[0]
table = img.parent.parent

links = table.findAll('a', attrs={'class':'hiddenlink'})

linklist = []

for link in links:
	href = link['href']
	if re.search(base, href):
		continue
	if re.search(r'https://', href):
		continue
	if re.search(r'/freetrial', href):
		continue
	if re.search(r'^/info/', href):
		continue
	if re.search(r'^/', href):
		continue

	m = re.search(r'http://(.*)', href)
	if not m:
		raise Exception, "Opps"

	linklist.append(m.group(1))
	print href

print "|".join(linklist)



