#!/usr/bin/python
import re, sys, urllib, urllib2, cookielib 
from BeautifulSoup import BeautifulSoup, Tag
from urllib2 import HTTPError
import BaseHTTPServer

cj=cookielib.CookieJar()
opener=urllib2.build_opener(urllib2.HTTPCookieProcessor(cj))

opener.addheaders=[('User-agent','Mozilla/5.0')]

testing = 0

if testing == 0:
	url = sys.stdin.readline().strip()
	#url = "http://scholar.google.com/scholar?hl=en&lr=&q=author%3A%22FG+GALLAGHER%22&btnG=Search"
	#url = "http://scholar.google.com/scholar?hl=en&lr=&q=author%3A%22a+einstein%22+-pdf&btnG=Search"
	#url = "http://scholar.google.com/scholar?hl=en&lr=&q=author%3A%22feynman%22+-pdf&btnG=Search"
	#url ="http://scholar.google.com/scholar?hl=en&lr=&q=drosophila+-pdf&btnG=Search"
	try:
		if url == "":
			url = "http://scholar.google.com/scholar"
		f = opener.open(url)
#		info = f.info()
#		print info
		data = f.read()
	except HTTPError, e:
		code = e.code
		try:
			msg = BaseHTTPServer.BaseHTTPRequestHandler.responses[code]
		except:
			print "Google Scholar error (1)", sys.exc_info()[0]
			sys.exit(0)
		
		if msg:
			print ("Google Scholar error: %s %s (%s)" % (code, msg[0], msg[1]))
		else:
			print "Google Scholar error (2): ", code
		sys.exit(0)
#	except:
#		print "Google Scholar error (3):", sys.exc_info()[0]
#		sys.exit(0)
else:
	data = sys.stdin.read()

soup = BeautifulSoup(data)
#print soup.prettify()
#sys.exit(0)


# make sure all image URL point to google
for img in soup.findAll("img"):
	if img.has_key('src') and img['src'].startswith('/'):
			img['src'] = "http://scholar.google.com" + img['src']

#
# Might be more robust to trawl ALL <A HREF=".."> (as class="w" might
# break) and replace those that start with absolute URL "http://"
# (filtering out any matching http://xxx.google.xxx/, just to be sure!)
#
items = soup.findAll("p", { "class" : "g" })

for item in items:
#	print div
	wspan = item.find("span", {"class" : "w"})
#	print wspan
	# Hmm, this should never happen, but it does!
	if not wspan:
		continue
	a = wspan.find('a')
	if not a:
		continue
	if not a['href']:
		continue
		
	cul = Tag(soup, "a")

	cul['href'] = "/posturl?url="+urllib.quote(a['href'])
	img = Tag(soup, "img")
	img['src']="http://static.citeulike.org/favicon.gif"
	img['style']="border:0"
	cul.insert(0,img)
	wspan.insert(99, cul)	
#	print wspan.prettify()

if testing == 0:
	print soup
else:
	print soup.prettify()

