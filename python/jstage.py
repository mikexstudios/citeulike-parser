#!/usr/bin/env python
# coding: utf-8
#
# Scraper for JSTAGE (Japanese Science and Technogy Information Aggregator, Electronic
# http://www.jstage.jst.go.jp/browse/-char/ja
#  by Osamu Masutani
#

import re, sys, urllib, urllib2,codecs
import socket

socket.setdefaulttimeout(15)


# URL parts
JSTAGE_URL = 'http://www.jstage.jst.go.jp/'
DOWNLOAD_URL = JSTAGE_URL + 'download/'
ARTICLE_URL = JSTAGE_URL + 'article/'
#ARTICLE_SUFFIX =  '/_article/-char/ja/'
#RIS_SUFFIX = '/_ris/-char/ja/'
#BIBTEX_SUFFIX = '/_bib/-char/ja/'
ARTICLE_SUFFIX =  '/_article'
RIS_SUFFIX = '/_ris'
BIBTEX_SUFFIX = '/_bib'

# read url from std input
url = sys.stdin.readline().strip()

# get article ID
jstage_id_regexp = ARTICLE_URL + '(.+)' + ARTICLE_SUFFIX
jstage_id_match = re.search(jstage_id_regexp, url, re.IGNORECASE)
if not jstage_id_match:
	print "Could not find id in URL (" + url + ")"
	sys.exit(1)
jstage_id = jstage_id_match.group(1)

url = ARTICLE_URL + jstage_id + ARTICLE_SUFFIX

# read article abstract page
article_data = urllib2.urlopen(url).read().strip()
# article_data = unicode(article_data,'cp932')
article_data.encode('utf-8')

# get abstract
abst = None
abst_regexp = '<!--Abstract-->(?: *?)<table border="0" cellpadding="2" cellspacing="0"><tr><td><nobr><B>(?:.*?)</B></nobr>(?:&nbsp;)*(?:<br>)*' + '(.*?)' + '</td></tr></table>';
abst_match = re.search(abst_regexp, article_data , re.IGNORECASE)
#if not abst_match:
#	print "Could not find abst in article page (" + url + ")"
#	sys.exit(1)
if abst_match:
	abst = abst_match.group(1)

doi = None
m = re.search(r'doi:(10.(\d{4})/[^<]+)', article_data)
if m:
	doi = m.group(1)

# get keywords
#keywords_regexp = '<B>Keywords:</B></TD><TD>(?:<a href="(?:.*?)">(.+?)</a>, )+?' + '<a href="(?:.*?)">(.+?)</a></TD>'
#keywords_match = re.search(keywords_regexp, article_data , re.IGNORECASE)
#if not keywords_match:
#	print "Could not find keywords in article page (" + url + ")"
#	sys.exit(1)
#keywords = keywords_match.groups

# change article url to RIS download url
# url2 = re.sub(ARTICLE_URL , DOWNLOAD_URL , url);
# url3 = re.sub(ARTICLE_SUFFIX ,  RIS_SUFFIX , url2);
url3 = DOWNLOAD_URL + jstage_id + RIS_SUFFIX

# fetch the citation export page
ris_data = urllib2.urlopen(url3).read().strip()
m = re.search("_in_Japanese", ris_data, re.IGNORECASE)
if m:
	ris_data = urllib2.urlopen(url3+"/-char/ja/").read().strip()

ris_data = re.sub("\nN1  - doi: .*\n","\n",ris_data)



# print the results
print "begin_ris"
print ris_data
print "end_ris"

print "begin_tsv"
if abst:
	print "abstract\t%s" % (abst.encode('utf-8'))
print "linkout\tJSTAGE\t\t%s\t\t" % jstage_id
if doi:
	print "linkout\tDOI\t\t%s\t\t" % doi

print "end_tsv"
print "status\tok"
