#!/usr/bin/env python

# Copyright (c) 2007 Richard Cameron <citeulike@askur.org>
# All rights reserved.
#
# This code is derived from software contributed to CiteULike.org
# by
#    Richard Cameron
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

# Read URL from stdin
url = sys.stdin.readline().strip()


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
	bail("Couldn't find and 'arNumber' field in the URL")

jar = cookielib.CookieJar()
handler = urllib2.HTTPCookieProcessor(jar)
opener = urllib2.build_opener(handler)
urllib2.install_opener(opener)

# Fetch the original page to get the session cookie
original = urlopen("http://ieeexplore.ieee.org/xpls/abs_all.jsp?arnumber=%d" % ar_number).read()

doi = re.findall(".*Digital Object Identifier\:.(10\...../[^<]+)<", original)

published = None
m = re.search("Published:\s+(\d+)-(\d+)-(\d+)", original)
if m:
	published = {}
	published["year"]=m.group(1)
	published["month"]=m.group(2)
	published["day"]=m.group(3)
if not published:
	m = re.search("Publication Date:\s+(\d+) (\w+) (\d+)", original)
	if m:
		months = { 'Jan': 1, 'Feb': 2, 'Mar': 3, 'Apr': 4, 'May': 5, 'Jun': 6, 'Jul': 7, 'Aug': 8, 'Sep': 9, 'Oct': 10, 'Nov': 11, 'Dec': 12 }
		published = {}
		published["year"]=m.group(3)
		try:
			published["month"]=months[m.group(2)]
		except:
			pass
		published["day"]=m.group(1)

# Post to get the RIS document
data = urlencode( { 'dlSelect' : 'cite_abs',
                    'fileFormate' : 'ris', # spelling mistake intentional (on their part)
                    'arnumber' : "<arnumber>%d</arnumber>" % ar_number,
                    'Submit' : 'Download' } )
ris =  urlopen("http://ieeexplore.ieee.org/xpls/citationAct", data).read()

if not re.search("TY  -", ris):
	bail("Can't fetch RIS record")

# We're seeing authors duplicated like this:
#  AU  - Dahele, J.
#  A1  - Dahele, J.
# Strip AU if both AU, A1 present. Should probably check that both sets of authors
# are identical if we are going to remove one...
if re.search("AU  -", ris) and re.search("A1  -", ris):
	ris_p = re.compile('^AU  - .*\n', re.M)
	ris = re.sub(ris_p, "", ris, re.M)

print "begin_tsv"

if doi:
	print "linkout\tDOI\t\t%s\t\t" % (doi[0])

if published:
	print "year\t%s" % published["year"]
	print "month\t%s" % published["month"]
	print "day\t%s" % published["day"]


print "linkout\tIEEE\t%d\t\t\t" % (ar_number)
print "end_tsv"
print "begin_ris"
print "%s" % (ris)
print "end_ris"
print "status\tok"

