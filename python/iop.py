#!/usr/bin/env python

#
# Copyright (c) 2007 Kristinn B. Gylfason <citeulike@askur.org>
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

import re, sys, urllib2
import socket
import BeautifulSoup
import htmlentitydefs
import codecs



socket.setdefaulttimeout(15)


def meta(soup, key):
	el = soup.find("meta", {'name':key})
	if el:
		return el['content'];
	return None

def item(soup, entry, key):
	el = meta(soup, key)
	if el:
		print "%s\t%s" % (entry, el)

def unescape(text):
    def fixup(m):
        text = m.group(0)
        if text[:2] == "&#":
            # character reference
            try:
                if text[:3] == "&#x":
                    return unichr(int(text[3:-1], 16))
                else:
                    return unichr(int(text[2:-1]))
            except ValueError:
                pass
        else:
            # named entity
            try:
                text = unichr(htmlentitydefs.name2codepoint[text[1:-1]])
            except KeyError:
                pass
        return text # leave as is
    #return re.sub("&#?\w+;", fixup, text).encode('utf-8')
    return re.sub("&#?\w+;", fixup, text)



# regexp to screen scrape the DOI and get the article info from it

sys.stdout = codecs.getwriter('utf-8')(sys.stdout)

# error messages
ERR_STR_PREFIX = 'status\terr\t'
ERR_STR_FETCH = 'Unable to fetch the page: '
ERR_STR_TRY_AGAIN = 'The server may be down.  Please try later.'

# read url from std input
url = sys.stdin.readline().strip()

# fetch the page the user is viewing and exit gracefully in case of trouble
try:
	f = urllib2.urlopen(url)
except:
	print ERR_STR_PREFIX + ERR_STR_FETCH + url + '.  ' + ERR_STR_TRY_AGAIN
	sys.exit(1)

content = f.read()

soup = BeautifulSoup.BeautifulSoup(content)

head = soup.find("head")

doi = meta(head, 'citation_doi')

"""
<meta name="dc.Title" content="IOP Publishing - IOPscience - 1980 Eur. J. Phys. 1 143 J M H Peters - Rayleigh's electrified water drops" />
<meta name="Title" content="IOP Publishing - IOPscience - 1980 Eur. J. Phys. 1 143 J M H Peters - Rayleigh's electrified water drops" />

<meta name="dc.Description" content="IOPscience is a unique platform for IOP-hosted journal content providing site-wide electronic access to more than 130 years of leading scientific research, and incorporates some of the most innovative technologies to enhance your user-experience." />
<meta name="Description" content="IOPscience is a unique platform for IOP-hosted journal content providing site-wide electronic access to more than 130 years of leading scientific research, and incorporates some of the most innovative technologies to enhance your user-experience." />
<meta name="robots" content="noarchive" />
<meta name="citation_volume" content="1" />
<meta name="citation_title" content="Rayleigh's electrified water drops" />
<meta name="citation_firstpage" content="143" />
<meta name="citation_date" content="1980-07-01" />
<meta name="dc.Date" content="1980-07-01" />
<meta name="citation_journal_title" content="European Journal of Physics" />
<meta name="citation_publisher" content="IOP Publishing" />
<meta name="citation_doi" content="10.1088/0143-0807/1/3/004" />
<meta name="citation_abstract_html_url" content="http://iopscience.iop.org/0143-0807/1/3/004" />
<meta name="citation_pdf_url" content="http://iopscience.iop.org/0143-0807/1/3/004/pdf/0143-0807_1_3_004.pdf" />
<meta name="citation_authors" content="Peters, J M H" />

<meta name="dc.Contributor" content="Peters, J M H"/>
"""

# print the results
print "begin_tsv"
print "type\tJOUR"

m = re.match(r'^10.\d\d\d\d/([^/]+)/([^/]+)/([^/]+)/([^/]+)', doi)
if m:
	print "linkout\tIOPDOI\t%s\t%s\t%s\t%s" % (m.group(2),m.group(1),m.group(3),m.group(4))
	print "issn\t%s" % m.group(1)
	print "volume\t%s" % m.group(2)
	print "issue\t%s" % m.group(3)
	print "cite\t%s-%s-%s-%s" % (m.group(1),m.group(2),m.group(3),m.group(4))

print "linkout\tDOI\t\t%s\t\t" % (doi)

print "doi\t%s" % doi
finalUrl = f.geturl()
finalUrl = re.sub(r'[?].*','', finalUrl)
print "url\t%s" % finalUrl


item(head, "title", "citation_title")
item(head, "journal", "citation_journal_title")
#item(head, "volume", "citation_volume")
item(head, "start_page", "citation_firstpage")
date = meta(head, 'dc.Date')
if date:
	m = re.match(r'(\d+)-(\d+)-(\d+)', date)
	if m:
		year = m.group(1)
		month = m.group(2)
		day = m.group(3)
		if year:
			print "year\t%s" % year
		if month:
			print "month\t%s" % month
		if day:
			print "day\t%s" % day

# authors
authors = head.findAll("meta", {"name":"dc.Contributor"})
if authors:
	for a in authors:
		print "author\t%s" % a['content']

# There's an abstract in the header but, for older articles, it's a dummy
# generic one, so easiest to scrape
# item(head,"abstract","dc.Description")
# Note the TYPO articleAbsctract
articleAbstract = soup.find(attrs={"id":"articleAbsctract"})
if not articleAbstract:
	articleAbstract = soup.find(attrs={"id":"articleAbstract"})
if articleAbstract:
	print "abstract\t%s" % unescape(" ".join(articleAbstract.findAll(text=True))).strip()

print "end_tsv"
print "status\tok"
