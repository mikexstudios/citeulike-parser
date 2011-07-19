#!/usr/bin/env python

# Copyright (c) 2011 Fergus Gallagher <fergus.gallagher@citeulike.org>
# All rights reserved.
#
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
#
#http://www.pensoft.net/journal_home_page.php?journal_id=1&page=article&type=show&article_id=1501
#http://www.pensoft.net/inc/journals/ris.php?articleId=1501&type=bib&journalId=1
#http://www.pensoft.net/journals/zookeys/article/1706/a-survey-of-the-east-palaearctic-lycosidae-araneae-9-genus-xerolycosa-dahl-1908-evippinae-


import socket, re, codecs, sys
import cookielib, urllib2, urlparse, cgi

sys.stdout = codecs.getwriter('utf-8')(sys.stdout)

socket.setdefaulttimeout(15)

url = sys.stdin.readline().strip()

m = re.search(r'/article/(\d+)/', url)
if m:
	article_id = m.group(1)
else:
	parsed_url = urlparse.urlparse(url)
	src_query = cgi.parse_qs(parsed_url.query)

	#journal_id = src_query['journal_id']
	article_id = src_query['article_id']
	if article_id:
		article_id = article_id[0]

if not article_id:
	print "status\terr\tUnable to extract Pensoft article"
	sys.exit(1)


BIBTEX_URL= "http://www.pensoft.net/inc/journals/ris.php?articleId=%s&type=bib" % (article_id, )

print "xxxx", BIBTEX_URL

cookie_jar = cookielib.CookieJar()
handlers = []
handlers.append( urllib2.HTTPCookieProcessor(cookie_jar) )

opener=urllib2.build_opener(*handlers)
opener.addheaders = [("User-Agent", "CiteULike/1.0 +http://www.citeulike.org/")]
urllib2.install_opener(opener)

try:
	bibtex = urllib2.urlopen(BIBTEX_URL).read();
except:
	print ERR_STR_PREFIX + "Could not fetch page (" + BIBTEX_URL + ")"
	sys.exit(1)

#
# Look for the DOI in the bibtex - it's usually like doi = {10.1145/1141911.1141931}
#
doi_match = re.search('doi\s*=\s*\{(10\.[^/]+/.+?)\}', bibtex,  re.IGNORECASE)

if doi_match:
	doi = doi_match.group(1)
else:
	doi = ''


print "begin_bibtex"
print bibtex
print "end_bibtex"
print "begin_tsv"
print "linkout\tPENSFT\t%s\t\t\t" % (article_id, )
if doi:
	print "linkout\tDOI\t\t%s\t\t" % (doi)

print "end_tsv"
print "status\tok"





#GET
#GET
