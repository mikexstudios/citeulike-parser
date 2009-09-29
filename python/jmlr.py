#!/usr/bin/env python2.5

import sys, re
from urllib import urlopen
from re import findall, sub
from htmlentitydefs import entitydefs

# regular expressions for extracting fields from the abstract page
content_re = r'<div id="content">(.*?)</div>'  # the content div
# all fields are extracted from the content div rather than the complete html
# to simplify the patterns
title_re = r'<h2>\s*(.*?)\s*</h2>'
author_re = r'<b>\s*<i>\s*(.*?)\s*</'
author_join_re = r'\s*,(?:\s*and)?\s*'
vol_month_pages_year_re = r'</i>.*?;\s*(.*?)\((.*?)\)\s*:\s*(\d+)--?(\d+),\s*(\d{4})'
abstract_re = r'<h3>\s*Abstract\s*</h3>\s*(.*?)\s*<(?:font |p)'

# error messages
ERR_STR_FETCH = 'Unable to fetch the bibliographic data: '
ERR_STR_TRY_AGAIN = 'The server may be down.  Please try later.'

# function to decode html entities in a string
def decodeentities(string):
    for (htmlent, ch) in entitydefs.items():
	string = string.replace('&'+htmlent+';', ch)
    return string

# function to strip html tags from a string
def striphtml(string):
    return sub(r'<[A-Za-z]+(?:\s+[A-Za-z]\s*=\s*(?:"[^"<>]*"|\'[^\'<>]*\'))*\s*/?>|</[A-Za-z]+>', "", string)

# function to extract regex matches from a string
# if the regex contains more than one () groups, returns a list of the matched
# groups; else returns a single match as a string
# if regex does not match, returns an emtpy string
# all matches are space normalized
def extract(regexp, string):
    matches = findall(regexp, string, re.IGNORECASE | re.DOTALL)
    if len(matches)==0:
	return ""
    match = matches[0]
    if isinstance(match,tuple):
	return map(lambda s: sub(r'\s+', ' ', s), match)
    else:
	return sub(r'\s+', ' ', match)

# read url from standard input
url = sys.stdin.readline()
# strip newline at the end
url = url.strip()

# get URL of the abstract page
(urlbase, urlext) = url.rsplit('.', 1)
abstracturl = urlbase+'.html'

# get the citation keys
# for example, http://jmlr.csail.mit.edu/papers/v5/lanckriet04a.html
# key1="5", key2="lanckriet04a"
keymatches = findall(r'/papers/v(.*?)/(.*)', urlbase)
(key1, key2) = keymatches[0]

# fetch the abstract page
try:
    f = urlopen(abstracturl)
except:
    print 'status\terr\t' + ERR_STR_FETCH + abstracturl + '.  ' + ERR_STR_TRY_AGAIN
    sys.exit(0)

months = { 'Jan': 1, 'Feb': 2, 'Mar': 3, 'Apr': 4, 'May': 5, 'Jun': 6, 'Jul': 7, 'Aug': 8, 'Sep': 9, 'Oct': 10, 'Nov': 11, 'Dec': 12 }

# get HTML
html = f.read()

# extract content div, decode html entities
content = decodeentities(extract(content_re, html))

# extract bibliographic fields
title = striphtml(extract(title_re, content))
authorstring = extract(author_re, content)
authors = re.compile(author_join_re).split(authorstring)
vol_month_pages_year = extract(vol_month_pages_year_re, content)
if isinstance(vol_month_pages_year, list):
    (volume,month,startpage,endpage,year) = vol_month_pages_year
else:
    (volume,month,startpage,endpage,year) = ("", "", "", "", "")
if month in months:
    monthnum = months[month]
else:
    monthnum = 0
abstract = striphtml(extract(abstract_re, content))
journal = 'Journal of Machine Learning Research'

# print the results
print 'begin_tsv'
for author in authors:
    print 'author\t%s' % author
print 'title\t%s' % title
print 'start_page\t%s' % startpage
print 'end_page\t%s' % endpage
print 'journal\t%s' % journal
print 'volume\t%s' % volume
print 'month\t%d' % monthnum
print 'year\t%s' % year
print 'abstract\t%s' % abstract
print 'url\t%s' % abstracturl
print 'type\tJOUR'
print 'linkout\tJMLR\t%s\t%s\t\t' % (key1, key2)
print 'end_tsv'
print 'status\tok'
