#!/usr/bin/env python2.6

# Copyright (c) 2010 Fergus Gallagher <fergus@citeulike.org>
# All rights reserved.
#
# This code is derived from software contributed to CiteULike.org
# by
#    Fergus Gallagher
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

import re, sys, cookielib, urllib2
from cultools import urlparams, bail
from urllib import urlencode, unquote
from urllib2 import urlopen
import socket
import BeautifulSoup
from html5lib import treebuilders
import html5lib
import warnings
import codecs

socket.setdefaulttimeout(15)

warnings.simplefilter("ignore",DeprecationWarning)


# Read URL from stdin
url = sys.stdin.readline().strip()

sys.stdout = codecs.getwriter('utf-8')(sys.stdout)


if url.startswith("http://ieeexplore.ieee.org/Xplore/login.jsp?url="):
	url = unquote(urlparams(url)["url"])


# Some IEEE urls are malformed and have ? characters instead of & to separate
# key-value pairs in the url.
s = url.split("?")

url_head = s[0]
url_tail = "&".join(s[1:])

# Some IEEE URLs look like ./a/b?&param=value - we need to sort this out
if url_tail[0] == '&':
	url_tail = url_tail[1:]

url = url_head + "?" + url_tail

try:
	ar_number = int(urlparams(url)["arnumber"])
except KeyError:
	bail("Couldn't find an 'arNumber' field in the URL")

jar = cookielib.CookieJar()
handler = urllib2.HTTPCookieProcessor(jar)
opener = urllib2.build_opener(handler)
urllib2.install_opener(opener)

# Fetch the original page to get the session cookie
original = urlopen("http://ieeexplore.ieee.org/xpl/freeabs_all.jsp?arnumber=%d" % ar_number).read()


parser = html5lib.HTMLParser(tree=treebuilders.getTreeBuilder("beautifulsoup"))
soup = parser.parse(original)

abstract = ''

abstractLink = soup.find('a',attrs={'name':'Abstract'})
if abstractLink:
	abstractDiv = abstractLink.parent
	abs = []
	for t in abstractDiv.findAll(text=True):
		if t != "Abstract":
			abs.append(t);
	abstract =  " ".join(abs).strip()


#body = soup.findAll('div',attrs={'class':'body-text'})
#print body

doi = None

aLinks = soup.findAll("a")
for a in aLinks:
	if not a.has_key("href"):
		continue
	href = a["href"]
	if href.startswith("http://dx.doi.org/"):
		match = re.search(r'(10\..*)', href)
		if match:
			doi = match.group(1)
		break


if not doi:
	bail("Couldn't find an DOI")


print "begin_tsv"

if doi:
	print "linkout\tDOI\t\t%s\t\t" % (doi)

if abstract != "":
	print "abstract\t%s" % abstract

print "linkout\tIEEE\t%d\t\t\t" % (ar_number)
print "end_tsv"
print "status\tok"

