#!/usr/bin/env python

# Copyright (c) 2010 Kristinn B. Gylfason <fergus@citeulike.org>
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
#

import re, sys, urllib2, urllib, cookielib, urlparse

import socket

socket.setdefaulttimeout(15)


# read url from std input and get rid of the newline at the end
url = sys.stdin.readline().strip()


# Wiley DOIs can have
# The (/\w+) at the end is optimistic.  Known values are /abstract + /full
# but I'll provisionally assume that a /<word> at the end is to be stripped.

url = re.sub(r';jsession.*','', url)

m = re.search('http://onlinelibrary.wiley.com/doi/(10\.\d\d\d\d/(.+?))(/\w+)?$', url, re.IGNORECASE)

if not m:
	print "status\terr\tCould not find doi in URL (" + url + ")"
	sys.exit(1)

doi = m.group(1)

# need to url decode DOI
doi = urllib.unquote(doi)

#http://onlinelibrary.wiley.com/doi/10.1111/j.1461-0248.2010.01465.x/full
#http://onlinelibrary.wiley.com/doi/10.1002/jcb.21099/abstract;jsessionid=833316DEC2536B0C334E85E5B4B19A0C.d03t01
#wget -O- --post-data="doi=10.1111%252Fj.1461-0248.2010.01465.x&fileFormat=REFERENCE_MANAGER&hasAbstract=CITATION_AND_ABSTRACT" http://onlinelibrary.wiley.com/documentcitationdownloadformsubmit

#print doi

cj = cookielib.CookieJar()
opener = urllib2.build_opener(urllib2.HTTPCookieProcessor(cj))

post_data = urllib.urlencode( { "doi" : doi,
				"fileFormat" : "REFERENCE_MANAGER",
				"hasAbstract" : "CITATION_AND_ABSTRACT"} )

post_url = "http://onlinelibrary.wiley.com/documentcitationdownloadformsubmit"
f = opener.open(post_url, post_data)

ris = f.read().strip()

#print post_url, post_data
#sys.exit(1)

# print the results
print "begin_tsv"
print "linkout\tDOI\t\t%s\t\t" % doi
print "type\tJOUR"
print "end_tsv"
print "begin_ris"
print ris
print "end_ris"
print "status\tok"
