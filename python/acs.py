#!/usr/local/bin/python

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

RIS_SERVER_ROOT = 'http://pubs.acs.org/servlet/citation/CitationServlet'
ACS_DOI_PREFIX = '10.1021'
DOI_SEP ='/'
ris_server_post_data = {'format':'refmgr', 'submit':'1'}

# regexp to grab article keys from the abstract url
KEYS_REGEXP = r"""abstract.cgi/	# begin at slash after 'abstract.cgi' string
		(\w*?)/		# 'coden' key is the alphanumeric string following the slash
		.*		# discard anything upto the 'abs' string
		/abs/(.*?).html$"""	# 'jid' key is terminated at '.html'
KEYS_REGEXP_FLAGS = re.IGNORECASE | re.VERBOSE

# error messages
ERR_STR_PREFIX = 'status\terr\t'
ERR_STR_FETCH = 'Unable to fetch the bibliographic data: '
ERR_STR_TRY_AGAIN = 'The server may be down.  Please try later.'
ERR_STR_NO_KEYS = 'Could not extract atricle details from the URL: '
ERR_STR_REPORT = 'Please report the error to plugins@citeulike.org.'

# read url from std input
url = sys.stdin.readline()

# get rid of the newline at the end
url = url.strip()

# parse the article details from the url and exit gracefully if not found
key_match  = re.search(KEYS_REGEXP, url, KEYS_REGEXP_FLAGS)
if not key_match:
	print ERR_STR_PREFIX + ERR_STR_NO_KEYS + url + '.  ' + ERR_STR_REPORT
	sys.exit(1)

jid = key_match.group(2)
doi = ACS_DOI_PREFIX + DOI_SEP + jid


from mechanize import Browser
br = Browser()
br.open("http://pubs.acs.org/wls/journals/citation2/Citation?jid="+jid)

br.select_form(nr=0)
br["includeAbstract"]=["citation-abstract"]
br["format"]=["plainRIS"]
response = br.submit()
ris = response.read()

# get rid of the extra newline at the end
ris_entry = ris.strip()

# print the results
print "begin_tsv"
print "linkout\tDOI\t\t%s\t\t" % (doi)
print "type\tJOUR"
print "doi\t" + doi
print "end_tsv"
print "begin_ris"
print ris_entry
print "end_ris"
print "status\tok"
