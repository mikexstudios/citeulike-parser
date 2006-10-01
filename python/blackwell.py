#!/usr/bin/env python2.4

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


import re, sys, urllib2, cookielib 

RIS_SERVER_ROOT = 'http://www.blackwell-synergy.com/action/downloadCitation'
RIS_SERVER_POST_STR = '?doi=%s&include=abs&format=refman'
DOI_URL_SEP ='%2F'
DOI_SEP ='/'

# regexp for document object identifiers (DOI)
DOI_REGEXP = r"""/		# begin at slash
		(10\.\S*?)/	# valid DOI prefixes start with '10.'
		(.*?)		# DOI suffixes can be anything
		\s*$"""		# terminate at end of line (strip witesp.)
DOI_REGEXP_FLAGS = re.IGNORECASE | re.VERBOSE

# error messages
ERR_STR_PREFIX = 'status\terr\t'
ERR_STR_FETCH = 'Unable to fetch the bibliographic data: '
ERR_STR_TRY_AGAIN = 'The server may be down.  Please try later.'
ERR_STR_NO_DOI = 'No document object identifier found in the URL: '
ERR_STR_REPORT = 'Please report the error to plugins@citeulike.org.'

# read url from std input
url = sys.stdin.readline()
# get rid of the newline at the end
url = url.strip()

# parse the DOI from the url and exit gracefully if not found
doi_match  = re.search(DOI_REGEXP, url, DOI_REGEXP_FLAGS)
if not doi_match:
	print ERR_STR_PREFIX + ERR_STR_NO_DOI + url + '.  ' + ERR_STR_REPORT
	sys.exit(1)

doi_prefix = doi_match.group(1)
doi_suffix = doi_match.group(2)
url_doi = doi_prefix + DOI_URL_SEP + doi_suffix
doi = doi_prefix + DOI_SEP + doi_suffix

# fetch the RIS entry for the DOI and exit gracefully in case of trouble
ris_url = RIS_SERVER_ROOT + RIS_SERVER_POST_STR % url_doi
cj = cookielib.CookieJar()
opener = urllib2.build_opener(urllib2.HTTPCookieProcessor(cj))
try:
	f = opener.open(ris_url)
except:
	print ERR_STR_PREFIX + ERR_STR_FETCH + url + '.  ' + ERR_STR_TRY_AGAIN
	sys.exit(1)

ris_entry = f.read()

# get rid of the extra newline at the end
ris_entry = ris_entry.strip()
# get rid of the session id in the url 
url_pat = re.compile(r';jsessionid.*$',re.MULTILINE)
ris_entry = re.sub(url_pat,'',ris_entry)
# get rid of the term "Abstract:" in the abstract
abs_pat = re.compile(r'^N2  - Abstract: ',re.MULTILINE)
ris_entry = re.sub(abs_pat,'N2  - ',ris_entry)

# print the results
print "begin_tsv"
print "linkout\tBWELL\t\t%s\t\t" % (doi)
print "linkout\tDOI\t\t%s\t\t" % (doi)
print "type\tJOUR"
print "doi\t" + doi
print "end_tsv"
print "begin_ris"
print ris_entry
print "end_ris"
print "status\tok"
