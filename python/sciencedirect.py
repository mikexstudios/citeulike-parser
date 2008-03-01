#!/usr/bin/env python

import sys, re, urllib2, cookielib
from urllib import urlencode
from urllib2 import urlopen
from copy import copy


class ParseException(Exception):
	pass

# Strip off any institutional proxies we find
def canon_url(url):
	m = re.match(r'http://[^/]*sciencedirect.com[^/]*/(science(\?_ob|/article).*$)', url)
	if not m:
		raise ParseException, "bad source url"
	return "http://www.sciencedirect.com/" + m.group(1)

def handle(url):
	yield "begin_tsv"
 
	page = urlopen( canon_url(url) ).read()
	
	# Talk about going round the bloody houses. There's an issue with the sciencedirect
	# website where if you bookmark a URL and then come back to it later and attempt
	# to follow the link to export a citation, it'll ultimately fail with a good old
	# "internal error" when you ask for the RIS file.
	#
	# The workaround is to fetch the article again from its DOI record. Awful.

	m = re.search(r'<a href="http://dx.doi.org/([^"]+)"', page)
	if m is not None:
		doi = m.group(1)
		yield "\t".join([ "linkout", "DOI", "", doi, "", ""])
		
		if doi.startswith("10.1016/"):
			# Fetch a fresh copy of the page
			doi_page = urlopen("http://dx.doi.org/"+doi).read()

			if "cannot be found in the Handle System" not in doi_page:
				page = doi_page
			
			# And now there's an even more rediculous hop, which is sometimes SD asks us whether
			# we want to get the article at sciencedirect or some other site. We'll need to follow that link too
			m = re.search(r'<a HREF="([^"]+)">\s+?Article via\s+ScienceDirect</a>', page)
			if m:
				page = urlopen( m.group(1).replace("&amp;", "&") ).read()

	# Look for an export citation link
	m = re.search("<a href=\"([^\"]+)\" onmouseover=\"document.images.'export'.", page)
	if not m:
		raise ParseException, "Are you looking at the full text or the summary of the article you're trying to add? Is it possible you tried to post a page containing a list of search results? I can't recognise your page as a ScienceDirect article. Try again when you're looking at the full-text page. It's the one with the full details of the article and a link on the right hand side saying 'Export Citation'"

	# That gives us something like
	# /science?_ob=DownloadURL&_method=confirm&_ArticleListID=221049524&_rdoc=1&_docType=FLA&_acct=C000010021&_version=1&_userid=121749&md5=5cc6c9b143ed2d9b07b54f9f463f027c
	# Follow it
	export_page = urlopen("http://www.sciencedirect.com"+m.group(1)).read()
	
	params = { "_ob" : "DownloadURL",
			   "_method" : "finish",
			   "format" : "cite-abs",
			   "citation-type" : "RIS",
			   "JAVASCRIPT_ON" : "Y",
			   "count" : "1",
			   "RETURN_URL" : "http://www.sciencedirect.com/science/home",
			   "Export" : "Export" }

	# Pick out all the hidden form elements we need to fetch the citation
	form = re.search(r'<form name="exportCite"(.*?)</form>', export_page, re.DOTALL).group(1)
	for (name, value) in re.findall(r'<input type=hidden name=(.*?) value=(.*?)>',
									form):
		if name not in params:
			params[name] = value

	# This is basically the point where I lose faith in the IT industry.
	# They seem to rely on the values being URL encoded in a particular order.
	# What the browser needs to do here is clearly not defined in the spec,
	# so it's just massive fluke that this works in the wild at all.
	# I wonder what sort of software they're using to unpack the data at the other end!
	oparams = []
	for k in [
		"_ob",
		"_method",
		"_acct",
		"_userid",
		"_docType",
		"_ArticleListID",
		"_uoikey",
		"count",
		"md5",
		"JAVASCRIPT_ON",
		"format",
		"citation-type",
		"Export",
		"RETURN_URL"]:
		if k in params:
			oparams.append( (k, params[k]) )
	

	# needs a cookie set in javascript. Clone one of the existing ones
#	for cookie in cookie_jar:
#		cookie = copy(cookie)
#		cookie.name="BROWSER_SUPPORTS_COOKIES"
#		cookie.value="1"
#		cookie_jar.set_cookie(cookie)
#		break

	request = urllib2.Request(url = "http://www.sciencedirect.com/science",
							  data = urlencode(oparams)
							  )
	ris = urlopen(request).read()


	# From the RIS we can get the sciencedirect linkout
	linkout = re.search(r'UR  - http://www.sciencedirect.com[^/]*?/science/article/(.+?)\n', ris).group(1)
	yield "\t".join([ "linkout", "SD", "", linkout.strip(), "", ""])

	yield "end_tsv"

	yield "begin_ris"
	yield ris
	yield "end_ris"

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
		
