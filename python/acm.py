#!/usr/bin/env python2.6

# Copyright (c) 2010 Oversity Ltd.
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
import sys, urllib, urllib2, urlparse, re, cookielib
import lxml.html, codecs

import socket

sys.stdout = codecs.getwriter('utf-8')(sys.stdout)

socket.setdefaulttimeout(15)

ACM_URL = 'http://portal.acm.org/'

ERR_STR_PREFIX = 'status\terr\t'

#
# Plugins get passed the URL as a line of stdin
#
url = sys.stdin.readline().strip()

url_query = urlparse.urlparse(url)[4]

# can be id=1234567 or id=1234567.7654321
# The last number seems to be the only significant one, but this code (and historical
# articles) doesn't take that into account, so there are duplicates in the database :-(
#
acm_id_match = re.search('id=(\d+([.]\d+)?|[A-Za-z0-9_-]+)', url_query, re.IGNORECASE)

if not acm_id_match:
	print ERR_STR_PREFIX + "Could not find id in URL (" + url + ")"
	sys.exit(1)

acm_id = acm_id_match.group(1)

#
# Fetch the page...
#

cookie_jar = cookielib.CookieJar()
handlers = []
handlers.append( urllib2.HTTPCookieProcessor(cookie_jar) )

opener=urllib2.build_opener(*handlers)
opener.addheaders = [("User-Agent", "CiteULike/1.0 +http://www.citeulike.org/")]
urllib2.install_opener(opener)

page_url = ACM_URL + 'citation.cfm?id=' + acm_id

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
#ColdFusion.Bind.register([],{'bindTo':'abstract','bindExpr':['tab_abstract.cfm?id=1141931&usebody=tabbody&cfid=://portal.acm.org/citation.cfm?id=1141911.1141931&cftoken=portal.acm.org/citation.cfm?id=1141911.1141931']},ColdFusion.Bind.urlBindHandler,true);
abstract_match = re.search("tab_abstract.cfm([^\']+)", page, re.IGNORECASE)
abs = []
if abstract_match:
	abstract_url = "http://portal.acm.org/%s" % abstract_match.group(0)
	abstract_page = urllib2.urlopen(abstract_url).read();
	root = lxml.html.fromstring(abstract_page)
	for div in root:
		t = div.text_content()
		if t:
			abs.append(t)

if len(abs) > 0:
	abstract =  " ".join(abs).strip()
else:
	abstract = ""

#
# Look for the link to the BibTeX export
#
# <a href="javascript:ColdFusion.Window.show('theformats');ColdFusion.navigate('exportformats.cfm?id=1141931&expformat=bibtex','theformats');" class="small-link-text">BibTeX</a>
bibtex_match = re.search("ColdFusion.navigate[(]'([^\']+bibtex)',", page, re.IGNORECASE)

if not bibtex_match:
	print ERR_STR_PREFIX + "Could not find BibTeX export link (popBibTex.cfm...) in page"
	sys.exit(1)

bibtex_url = ACM_URL + bibtex_match.group(1)

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
bib_match = re.search('<pre id="[^"]+">(.+?)</pre>', bibtex_page, re.IGNORECASE | re.DOTALL)

if not bib_match:
	print bibtex_page
	print ERR_STR_PREFIX + "Could not find BibTeX in page"
	sys.exit(1)

bibtex = bib_match.group(1).strip()


#
# Look for the DOI in the bibtex - it's usually like doi = {http://doi.acm.org/10.1145/1141911.1141931}
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
