#!/usr/bin/env python

#
# Copyright (c) 2007 Hamish Harvey
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

import re
import string
import sys
import urllib2
import textwrap

url = sys.stdin.readline()
url = url.strip()
keys = re.search("iwaponline\.com/([^\.]+)/(\d+)/\\1\\2(\d+)\.htm", url)
ckey_1 = keys.group(1)
ikey_1 = keys.group(2)
ikey_2 = keys.group(3)
print "begin_tsv"
print "linkout\tIWAP\t%s\t%s\t%s\t" % (ikey_1, ckey_1, ikey_2)
print "url\t%s" % url

f = urllib2.urlopen(url)
content = f.read()

doi_m  = re.search("PPL\.DOI\"\s*CONTENT=\"(10\.\d*?/[^\.]*?\.[^\.]*?\.[^\.]*?)\"", content, re.IGNORECASE)
if doi_m:
    print "linkout\tDOI\t\t%s\t\t" % doi_m.group(1)
    print "doi\t%s" % doi_m.group(1)

title_m  = re.search("DC\.Title\"\s*CONTENT=\"(.*)\"", content, re.IGNORECASE)
if title_m != None:
    title = title_m.group(1)
    print "title\t%s" % title.strip()

author_m = re.search("<H3>(.*)</H3>", content, re.IGNORECASE)
if author_m != None:
    tmp = author_m.group(1).split('and')
    if len(tmp) > 1:
        authors = tmp[0].split(", ")
        authors.append(tmp[1])
    else:
        authors = tmp
    for author in authors:
        print "author\t%s" % author.strip()

year_m = re.search("DC\.Date\" CONTENT=\"(\d{4,4})", content, re.IGNORECASE)
if year_m != None:
    year = year_m.group(1)
    print "year\t%s" % year

volume_m = re.search("PPL\.Volume\" CONTENT=\"(\d+)", content, re.IGNORECASE)
if volume_m != None:
    volume = volume_m.group(1)
    print "volume\t%s" % volume

issue_m = re.search("PPL\.Issue\" CONTENT=\"(\d+)", content, re.IGNORECASE)
if issue_m != None:
    issue = issue_m.group(1)
    print "issue\t%s" % issue

print "publisher\tIWA Publishing"

keywords_m = re.search("<p><b>Keywords:</b>\s*(.*?)</p>", content, re.IGNORECASE)
if keywords_m != None:
    keywords = keywords_m.group(1)
    print "keywords\t%s" % keywords

pages_m = re.search("<b>Vol\s\d+\sNo\s\d+\spp\s(\d+)&#0?150;(\d+)", content, re.IGNORECASE)
if pages_m != None:
    start_page = pages_m.group(1)
    end_page = pages_m.group(2)
    print "start_page\t%s" % start_page.strip()
    print "end_page\t%s" % end_page.strip()

abstract_m = re.search("<b>ABSTRACT</b><br>..<p>(.*?)</p>", content, re.DOTALL | re.IGNORECASE)
abstract = abstract_m.group(1)

journal_m = re.search("<p>(.*)\s*<b>Vol", content, re.DOTALL | re.IGNORECASE)
if journal_m != None:
    journal = journal_m.group(1)
    print "journal\t%s" % journal.strip()

abstract = " ".join(textwrap.wrap(abstract.strip()))

print "abstract\t%s" % abstract

print "type\tJOUR"
print "end_tsv"
print "status\tok"
