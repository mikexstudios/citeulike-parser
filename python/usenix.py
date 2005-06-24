#!/usr/bin/env python

import re
import string
import sys
import urllib2

url = sys.stdin.readline()
keys = re.search("events/(\S*)/tech/(\S*).html", url)
ckey_1 = keys.group(1)
ckey_2 = keys.group(2)
print "begin_tsv"
print "linkout\tUSENX\t\t%s\t\t%s" % (ckey_1, ckey_2)

f = urllib2.urlopen(url)
content = f.read()

title_m  = re.search("<H2>(.*)\s*</H2>", content, re.IGNORECASE)
if title_m != None:
    title = title_m.group(1)
    print "title\t%s" % title.strip()

author_m = re.search("</H2>\s*(.*),\s*<i>", content, re.IGNORECASE)
if author_m != None:
    tmp = author_m.group(1).split('and')
    if len(tmp) > 1:
        authors = tmp[0].split(", ")
        if authors[len(authors)-1]=='':
            authors = authors[:len(authors)-1] 
            authors.append(tmp[1])
        else:
            authors = tmp
    for author in authors:
        print "author\t%s" % author.strip()

pages_m = re.search("(\d+)&#150;(\d+)", content, re.IGNORECASE)
if pages_m != None:
    start_page = pages_m.group(1)
    end_page = pages_m.group(2)
    print "start_page\t%s" % start_page.strip()
    print "end_page\t%s" % end_page.strip()

abstract_m = re.search("</H3>(.*)<UL>", content, re.DOTALL | re.IGNORECASE)
abstract = abstract_m.group(1)

journal_m = re.search("<b>(.*)\s*&#151;\s*Abstract(</b>)?</font>", content, re.DOTALL | re.IGNORECASE)
if journal_m != None:
    journal = journal_m.group(1)
    print "journal\t%s" % journal.strip()
else:
    journal_m = re.search("<HEAD><TITLE>(.{,20} \'\d+)", content, re.DOTALL | re.IGNORECASE)
    if journal_m != None:
        journal = journal_m.group(1)
        print "journal\t%s" % journal.strip()


#print "abstract %s" % abstract
print "type\tINCONF"
print "end_tsv"
print "status\tok"
