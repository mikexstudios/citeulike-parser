#!/usr/bin/env python

# Copyright (c) 2009 Fergus Gallagher <fergus.gallagher@citeulike.org>
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

import sys, re, codecs
from urllib2 import urlopen
from urlparse import urlparse
url = sys.stdin.readline().strip()

sys.stdout = codecs.getwriter('utf-8')(sys.stdout)


article_id=""
article=""
journal=""
art_app=""
volissue=""


m = re.search(r'article_id=(\d+)', url )
if m:
	article_id = m.group(1)

m = re.search(r'article=(\d+)', url )
if m:
	article = m.group(1)


if article=="" and article_id=="":
	print "status\terr\tInvalid URL cannot find and article ID"
	sys.exit(0)

m = re.search(r'volissue=(\d+)', url )
if m:
	volissue = m.group(1)

m = re.search(r'journal=(\d+)', url )
if m:
	journal= m.group(1)

m = re.search(r'art_app=(YES)', url )
if m:
	art_app = m.group(1)

risUrl = "http://www.thepcrj.org/journ/citeulike_ris.php?article_id=%s&article=%s&volissue=%s&journal=%s&art_app=%s" % (article_id,article,volissue,journal,art_app)

print "Opening", risUrl

ris = urlopen(risUrl).read().decode("cp1250")
#ris = urlopen(risUrl).read().decode("iso8859-1")


print "begin_tsv"
print "\t".join([ "linkout",  "PCRJ", "", "%s"% "/".join([article_id,article,volissue,journal,art_app]), "", ""])

m = re.search("DO  - (\S*)",ris,re.MULTILINE)
if m:
	print "\t".join([ "linkout", "DOI", m.group(1), "", "", ""])

print "end_tsv"

print "begin_ris"
print ris
print "end_ris"

print "status\tok"
