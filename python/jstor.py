#!/usr/bin/env python

#
# Copyright (c) 2008 Richard Cameron
# All rights reserved.
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
#		 CiteULike <http://www.citeulike.org> and its
#		 contributors.
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

from urllib2 import urlopen
import urllib2, urllib, re
import socket

socket.setdefaulttimeout(15)


def url_to_id(url):

	# If there's a DOI then we'll have that
	m = re.search(r'doi=10.2307/(\d+)', url)
	if m:
		return int(m.group(1))

	# If it's the old style SICI then, annoyingly, we'll need to fetch it
	if 'sici=' in url:
		page = urlopen(url).read()
		m = re.search(r'<a id="info" href="/stable/(\d+)">Article Information</a>', page)
		if m:
			return int(m.group(1))
		else:
			return None

	# Otherwise assume anything which looks like /123123/ is an ID
	#m = re.search(r'https?://.*?jstor.+?/(\d{4,})(/|$|\?|#)', url)
	m = re.search(r'https?://.*?jstor.+?/(\d{4,})', url)
	if m:
		return int(m.group(1))
	return None

def grab_bibtex(id):
	url = "http://www.jstor.org/action/downloadCitation?format=bibtex&include=abs"
	params = {
		'noDoi' : 'yesDoi',
		'doi' : '10.2307/%s' % id,
		'suffix' : id,
		'downloadFileName' : id }

	page = urlopen(url, urllib.urlencode(params)).read()

	# Remove the random junk found in the record
	m = re.search(r'@comment{{NUMBER OF CITATIONS : 1}}(.*)@comment{{ These records have been provided', page, re.M|re.DOTALL)
	if m:
		page = m.group(1)

	# This bit is fun. Book reviews come through as [untitled]. Piece things back together for them
	if "title = {Review: [untitled]}," in page and "reviewedwork_1 = {" in page:
		work_title = re.search(r'reviewedwork_1 = {(.+?)},', page).group(1)
		page = page.replace('{Review: [untitled]}', "{Review: [%s]}" % work_title)

	return page

def parse_citation(s):
	re.compile(r'<li class="sourceInfo">\s+<cite>(.*?)</cite>, Vol. ([^,]+)')

def main(id):
	if not id:
		print "\t".join([ "status", "err", "Could not identify this as being a JSTOR article" ])
		sys.exit(1)

	print "begin_tsv"
	print "\t".join([ "linkout", "JSTR2", "%d"%id, "", "", ""])
	print "\t".join([ "linkout", "DOI", "", "10.2307/%d"%id, "", ""])
	print "end_tsv"

	print "begin_bibtex"
	print grab_bibtex(id)
	print "end_bibtex"

	print "status\tok"

if __name__=="__main__":
	import sys
	url = sys.stdin.readline().strip()

	# Cookie me.
	opener = urllib2.build_opener(urllib2.HTTPCookieProcessor())
	urllib2.install_opener(opener)
	urlopen("http://www.jstor.org/action/showCitFormats")

	jstor_id = url_to_id(url)
	main(jstor_id)
