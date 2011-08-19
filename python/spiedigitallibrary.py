#!/usr/bin/env python2.6
# Copyright (c) 2011 Fergus Gallagher <fergus@citeulike.org>
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

import socket, codecs, sys
from urlparse import urlparse
from cultools import urlparams, bail

import metaheaders

socket.setdefaulttimeout(15)

# Read URL from stdin
url = sys.stdin.readline().strip()

u = urlparse(url)

# rewrite the URL - need ?isAuthorized=no to avoid redirect loop
url = "%s://%s%s?isAuthorized=no" % (u.scheme, u.netloc, u.path)

sys.stdout = codecs.getwriter('utf-8')(sys.stdout)

metaheaders = metaheaders.MetaHeaders(url)

print "begin_tsv"


if metaheaders.get_item("citation_conference"):
	print "type\tINCONF"
else:
	print "type\tJOUR"


authors = metaheaders.get_multi_item("citation_author")
if authors:
	for a in authors:
		print "author\t%s" % a

metaheaders.print_item("title","citation_title")
metaheaders.print_date("citation_date")
metaheaders.print_item("volume","citation_volume")
metaheaders.print_item("start_page","citation_firstpage")
metaheaders.print_item("end_page","citation_lastpage")
metaheaders.print_item("issue","citation_issue")
metaheaders.print_item("serial","citation.issn")
publisher = metaheaders.get_item("citation_publisher")
if publisher:
	publisher = publisher.replace("COPYRIGHT SPIE--","")
	publisher = publisher.replace("Downloading of the abstract is permitted for personal use only.","")
	print "publisher\t%s" % publisher.strip()

metaheaders.print_item("abstract","description")
metaheaders.print_item("journal","citation_journal_title")
metaheaders.print_item("title_secondary","citation_conference")

doi = metaheaders.get_item("citation_doi")
if doi:
	doi = doi.replace("doi:","")
	print "doi\t%s" % doi
	print "linkout\tDOI\t\t%s\t\t" % (doi)
else:
	bail("Couldn't find an DOI")

print "end_tsv"
print "status\tok"

