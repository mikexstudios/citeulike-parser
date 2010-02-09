#!/usr/bin/env python

# Copyright (c) 2006 Kristinn B. Gylfason <citeulike@askur.org>
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

import re, sys, urllib, urllib2
import socket

socket.setdefaulttimeout(15)


ACS_URL = 'http://pubs.acs.org'

CITATION_FORMATS_URL  = ACS_URL + '/action/showCitFormats'
CITATION_DOWNLOAD_URL = ACS_URL + '/action/downloadCitation'

# DOI is in the URL - this is what we need to get citation information
URL_DOI_REGEXP       = '(10[.]\d+/[^/?&]+)'
URL_DOI_REGEXP_FLAGS = re.IGNORECASE | re.VERBOSE

# error messages
ERR_STR_PREFIX    = 'status\terr\t'
ERR_STR_FETCH     = 'Unable to fetch the bibliographic data: '
ERR_STR_TRY_AGAIN = 'The server may be down.  Please try later.'
ERR_STR_NO_DOI    = 'Could not extract DOI from the URL: '
ERR_STR_REPORT    = 'Please report the error to plugins@citeulike.org.'

# read url from std input
url = sys.stdin.readline().strip()

# parse the article details from the url and exit gracefully if not found
doi_match  = re.search(URL_DOI_REGEXP, url, URL_DOI_REGEXP_FLAGS)
if not doi_match:
	print ERR_STR_PREFIX + ERR_STR_NO_DOI + url + '.  ' + ERR_STR_REPORT
	sys.exit(1)

doi = doi_match.group(1)
doi = urllib.unquote(doi)

# Fetch the citation export page - shouldn't need to (we don't require anything from the page),
# but this is one of those sites that just insists on using cookies session tracking

cookiejar = urllib2.HTTPCookieProcessor()
opener    = urllib2.build_opener(cookiejar)

urllib2.install_opener(opener)

cit_url = CITATION_FORMATS_URL + '?' + urllib.urlencode({ 'doi' : doi})

cit_page = urllib2.urlopen(cit_url).read()

citation_post_data = {
	'doi'              : doi,
	'downloadFileName' : 'ref',
        'include'          : 'abs',
        'format'           : 'refman',
        'submit'           : 'Download article citation data'
}

ris_data = urllib2.urlopen(CITATION_DOWNLOAD_URL, urllib.urlencode(citation_post_data)).read().strip()
ris_data = re.sub("\nN1  - doi: .*\n","\n",ris_data)

# print the results
print "begin_tsv"
print "linkout\tDOI\t\t%s\t\t" % (doi)
print "type\tJOUR"
print "doi\t" + doi
print "end_tsv"
print "begin_ris"
print ris_data
print "end_ris"
print "status\tok"
