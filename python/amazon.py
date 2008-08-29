#!/usr/bin/env python

# Copyright (c) 2006 Oversity Ltd.
# All rights reserved.
#
# This code is derived from software contributed to CiteULike.org
# by
#    Diwaker Gupta
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
# 3. All advertising materials mentioning features or use of this software
#    must display the following acknowledgement:
#        This product includes software developed by
#                CiteULike <http://www.citeulike.org> and its
#                contributors.
# 4. Neither the name of CiteULike nor the names of its
#    contributors may be used to endorse or promote products derived
#    from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY CITEULIKE.ORG AND CONTRIBUTORS
# ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
# TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE FOUNDATION OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
#
import re, os
import isbn, ecs
from html2text import html2text
	
class BadUrl(Exception):
	pass

# Bear with me. I'm on an ancient version of Python here.
class UserException(Exception):
	def __init__(self, message):
		Exception.__init__(self)
		self.message=message

def parse_url(url):
	"""Try to get the amazon product ID (ASIN) out of the url.
	Returns (domain, asin) where domain is .co.uk/.com/.de etc"""
	
	regexps = [r'amazon\.(?P<domain>[a-z.]+)/(?:gp|exec|o)/.*/?(?:ASIN|-|product)/(?P<asin>[^?/]+)',
			   r'amazon.(?P<domain>[a-z.]+)/[^/]+/(gp|dp)/(?P<asin>[0-9X]+)',
			   r'amazon.(?P<domain>[a-z.]+)/([^/]+/)?dp/(?P<asin>[^/]+)'
			   ]
	
	for r in regexps:
		m = re.search(r, url, re.I)
		if m:
			return m.group('domain', 'asin')

	# Start trying to find odd cases now.
	m = re.search(r'amazon.([a-z.]+)/', url)
	if not m:
		# I can't even see which amazon domain it's from. Time to give up.
		raise BadUrl(url)
	domain = m.group(1)

	# Maybe there's something that
	# looks like an ISBN sandwiched between two path separators
	for part in url.split("/"):
		v = isbn.verify(part)
		if v:
			return (domain, v)

	# Hunt through the URL looking for any sequence of characters
	# which look like an ISBN
	candidates = list(isbn.hunt(url))
	if len(candidates==1):
		return (domain, candidates[0])

	# Nope. I give up.
	raise BadUrl(url)

def tidy(s):
	return s.replace("\t", " ").strip()
		   
def extract(node, path):
	"""Pull bits of data out of the ecs bag structure"""
	ptr = node
	for item in path:
		if hasattr(ptr, item):
			ptr = getattr(ptr, item)
		else:
			return None
	return ptr

def fetch(domain, asin):
	
	locale = {'com' : 'us',
			  'co.uk' : 'uk',
			  'de' : 'de',
			  'co.jp' : 'jp',
			  'fr' : 'fr',
			  'ca' : 'ca'}[domain]

	ecs.setLocale(locale)
	try:
		pages = ecs.ItemLookup(asin, ResponseGroup="Medium")
	except ecs.InvalidParameterValue, e:
		raise UserException, str(e)
	if len(pages)>1:
		raise UserException("The Amazon API returned multiple items for this book. This shouldn't happen. Please contact <bugs@citeulike.org>")
	if len(pages)==0:
		raise UserException, "Couldn't find any results for ISBN %s on the amazon.%s site." % (asin, domain)
	if len(pages)==0:
		pass
	
	page = pages[0]

	field_map = [
		(['Title'], 'title'),
		(['ISBN'] , 'isbn'),
		(['Publisher'], 'publisher'),
		(['Edition'], 'edition'),
		(['Binding'], 'how_published'),
		]
	
	amazon_type = extract(page, ["ProductGroup"])
	if amazon_type!="Book":
		raise UserException("This item on Amazon does not appear to be a book. It looks like a %s" % amazon_type)
	else:
		yield ("type", "BOOK")

	for (path, our_name) in field_map:
		val = extract(page, path)
		if val:
			yield(our_name, tidy(val))

	date = extract(page, ['PublicationDate'])
	if date:
		try:
			(year, month, day) = date.split("-")
			yield ("year", year)
			yield ("month", month)
			yield ("day", day)
		except ValueError:
			pass

	authors = extract(page, ['Author'])
	if authors:
		if isinstance(authors, basestring):
			yield ("author", tidy(authors))
		else:
			for author in authors:
				yield ("author", tidy(author))

	# We put the images in as linkouts. CiteULike uses these
	# internally to show cover images.
	for (theirs, ours) in [('SmallImage', 'IMGS'),
						   ('MediumImage', 'IMGM'),
						   ('LargeImage', 'IMGL')]:
		path = [theirs, "URL"]
		img_url = extract(page, path)
		if img_url:
			yield ("linkout", "\t".join([ours, "", img_url, "", ""]))

	isbn = extract(page, ['ISBN'])
	if isbn:
		yield ("linkout", "\t".join(["ISBN", "", isbn, "", ""]))

	def get_abstract(n):
		abstract = extract(n, ['EditorialReviews', 'EditorialReview', 'Content'])
		if abstract:
			return tidy(html2text(abstract))

	seen_abstract = False
	if not seen_abstract:
		abstract = get_abstract(page)
		if abstract:
			yield ("abstract", abstract)
			seen_abstract = True

	# Linkouts to the ASINS

	yield ("linkout", "\t".join(["AZ-%s" % locale.upper(),
								 "", asin, "", ""]) )
	# Different amazons may know this product by a different
	# ASIN. Trawl through all of them and see who has this one.
	for other_locale in ["us", "uk", "de", "jp", "fr", "ca"]:

			
		if other_locale==locale:
			continue
		ecs.setLocale(other_locale)
		try:
			pages = ecs.ItemLookup(asin, ResponseGroup="Medium")
		except ecs.InvalidParameterValue:
			continue
		if len(pages)!=1:
			continue
		
		page = pages[0]
		if not seen_abstract:
			abstract = get_abstract(page)
			if abstract:
				yield ("abstract", abstract)
				seen_abstract = True

		yield ("linkout", "\t".join(["AZ-%s" % other_locale.upper(),
									 "", asin, "", ""]) )

def test_parse_url():
	tests = [("http://www.amazon.com/gp/product/0380715430", 
			  "com", 
			  "0380715430"),
			 ("http://www.amazon.com/Galileo-Courtier-Absolutism-Conceptual-Foundations/dp/0226045609/ref=sr_1_1?ie=UTF8&s=books&qid=xxx&sr=8-1",
			  "com",
			  "0226045609"),
			 ("http://www.amazon.com/something/unusual/0226045609",
			  "com",
			  "0226045609"),
			 ("http://www.amazon.com/some-very-strange-url-with-0226045609-isbn",
			  "com",
			  "0226045609"),
			 ]

	msg = "Couldn't extract %s (got: %s expected %s) from %s"
	for (url, domain, asin) in tests:
		(pdomain, pasin) = parse_url(url)
		if pdomain!=domain:
			raise Exception( msg % ("domain", pdomain, domain, url) )
		if pasin!=asin:
			raise Exception( msg % ("asin", pasin, asin, url) )


def secret_key():
	"""Rather than just putting the key which Amazon gave me to use their
	API (and told me not to tell anyone) in plaintext in the scraper, we'll
	read it from ~/.amazon-aws-key instead. Put yours there."""

	amazon_key_file = os.path.expanduser("~/.amazon-aws-key")

	if not os.path.exists(amazon_key_file):
		raise Exception("I can't find your secret amazon key in " + amazon_key_file)
	return open(amazon_key_file).read().strip()

def main():
	import sys

	ecs.setLicenseKey( secret_key() )

	if "--test" in sys.argv:
		test_parse_url()

	url = sys.stdin.readline().strip()
	
	(domain,asin) = parse_url(url)
	print "begin_tsv"
	for (k,v) in fetch(domain, asin):
		print unicode("%s\t%s" % (k,v)).encode("utf8")
	print "end_tsv"


if __name__=="__main__":

	# Don't use proxies for Amazon, go direct.
	# This is a rather nasty hack - RDC
	os.environ['http_proxy'] = ''

	try:
		main()
		print "status\tok"
	except BadUrl, e:
		print "\t".join(["status", "err", "The page you submitted did not look like a single book on the Amazon site. Were you looking at a list of search results, or a general page on the site?"])
	except UserException, e:
		print "\t".join(["status", "err", e.message])
	except Exception, e:
		print "\t".join(["status", "err", str(e)])
		raise
