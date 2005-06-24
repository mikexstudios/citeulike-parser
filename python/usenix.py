#!/usr/bin/env python

#
# Copyright (c) 2005 Richard Cameron, CiteULike.org
# All rights reserved.
#
# This code is derived from software contributed to CiteULike.org
# by: Diwaker Gupta <diwakergupta AT yahoo DOT com>
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

import re
import string
import sys
import urllib2

url = sys.stdin.readline()
keys = re.search("(events/|publications/library/proceedings/)(\S*)/tech/(\S*).html", url)
ckey_1 = keys.group(2)
ckey_2 = keys.group(3)

f = urllib2.urlopen(url)
content = f.read()

title_m  = re.search("<H2>(.*)\s*</H2>", content, re.IGNORECASE)
title = title_m.group(1)

author_m = re.search("</H2>\s*(.*),\s*<i>", content, re.IGNORECASE)
tmp = author_m.group(1).split('and')
print tmp
if len(tmp) > 1:
    authors = tmp[0].split(", ")
    if authors[len(authors)-1]=='':
        authors = authors[:len(authors)-1] 
    authors.append(tmp[1])
else:
    authors = tmp

pages_m = re.search("(\d+)&#150;(\d+)", content, re.IGNORECASE)
start_page = pages_m.group(1)
end_page = pages_m.group(2)

abstract_m = re.search("</H3>(.*)<UL>", content, re.DOTALL | re.IGNORECASE)
abstract = abstract_m.group(1)

journal_m = re.search("<b>(.*)\s*&#151;\s*Abstract(</b>)?</font>", content, re.DOTALL | re.IGNORECASE)
journal = journal_m.group(1)


print "begin_tsv"
print "linkout\tUSENX\t\t%s\t\t%s" % (ckey_1, ckey_2)
print "title\t%s" % title
for author in authors:
    print "author\t%s" % author.strip()
print "journal\t%s" % journal.strip()
print "start_page\t%s" % start_page.strip()
print "end_page\t%s" % end_page.strip()
#print "abstract %s" % abstract
print "type\tINCONF"
print "end_tsv"
print "status\tok"
