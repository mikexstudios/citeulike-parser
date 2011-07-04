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
from html5lib import treebuilders
import html5lib
import warnings
import codecs
import metaheaders
#from subprocess import Popen, PIPE
from lxml import etree

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


metaheaders = metaheaders.MetaHeaders("http://ieeexplore.ieee.org/xpl/freeabs_all.jsp?arnumber=%d" % ar_number)

root = metaheaders.root

abstract = ''

abstractDiv = root.xpath("//a[@name='Abstract']/../*/text()")

if abstractDiv:
	abstract = abstractDiv[0]
	abstract = re.sub("^Abstract\s*", "", abstract).strip()

#print etree.tostring(root, pretty_print=True)

doi = metaheaders.get_item("citation_doi")
if not doi:
	aLinks = root.cssselect("a")

	for a in aLinks:
		if not a.attrib.has_key("href"):
			continue
		href = a.attrib["href"]
		if href.startswith("http://dx.doi.org/"):
			match = re.search(r'(10\..*)', href)
			if match:
				doi = match.group(1)
			break




print "begin_tsv"

print "type\tJOUR"

if True and metaheaders.get_item("citation_title"):
	metaheaders.print_item("title","citation_title")
	metaheaders.print_item("publisher","citation_publisher")
	authors = metaheaders.get_multi_item("citation_author")
	if authors:
		for a in authors:
			print "author\t%s" % a
	else:
		metaheaders.print_item("author","citation_authors")
	metaheaders.print_item("volume","citation_volume")
	metaheaders.print_item("issue","citation_issue")
	metaheaders.print_item("start_page","citation_firstpage")
	metaheaders.print_item("end_page","citation_lastpage")
	# "serial" or "issn".  Do both, to be safe
	metaheaders.print_item("serial","citation_issn")
	metaheaders.print_item("issn","citation_issn")
	metaheaders.print_item("isbn","citation_isbn")
	metaheaders.print_item("title_secondary","citation_conference")
	metaheaders.print_date("citation_date")
	metaheaders.print_item("journal","citation_journal_title")
	metaheaders.print_item("publisher","citation_publisher")

	# date is sometimes (always?) like "Oct. 2004"
	date = metaheaders.get_item("citation_date")

else:
	if not doi:
		bail("Couldn't find an DOI")
	print "use_crossref\t1"

if doi:
	print "linkout\tDOI\t\t%s\t\t" % (doi)

if abstract != "":
	print "abstract\t%s" % abstract

print "linkout\tIEEE\t%d\t\t\t" % (ar_number)
print "end_tsv"
print "status\tok"

