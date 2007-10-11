#!/usr/bin/env python

import sys
from urllib import urlopen

# error messages
ERR_STR_FETCH = 'Unable to fetch the bibliographic data: '
ERR_STR_TRY_AGAIN = 'The server may be down.  Please try later.'

# read url from standard input
url = sys.stdin.readline()
# strip newline at the end
url = url.strip()

# http://www.aclweb.org/anthology/W/W07/W07-0101.bib is an html page with an
# http-equiv meta that redirects to
# http://www.aclweb.org/anthology-new/W/W07/W07-0101.pdf, but we need to fetch
# the bib file; if we replace /anthology/ with /anthology-new/ we get the bib
# file
urlparts = url.split('/')
if urlparts[3] == 'anthology':
    urlparts[3] = 'anthology-new'
url = '/'.join(urlparts)

# strip off .bib, .pdf
if url.endswith('.bib') or url.endswith('.pdf'):
    baseurl = url[0:url.rfind('.')]
else:
    baseurl = url

# construct url for bib file
biburl = baseurl + '.bib'
# get the citation key (e.g. W/W07/W07-1001)
key = '/'.join(baseurl.split('/')[4:])

# fetch the bib file
try:
    f = urlopen(biburl)
except:
    print 'status\terr\t' + ERR_STR_FETCH + url + '.  ' + ERR_STR_TRY_AGAIN
    sys.exit(0)

bib = f.read()

# check if we got BibTeX or a HTML page redirecting to the pdf file (some
# papers have pdf only)
if bib.find('author') == -1 or bib.find('title') == -1 or bib.find('year') == -1:
    print 'status\tnot_interested'
    sys.exit(0)

# strip newlines at the end
bib = bib.strip()

# print the results
print 'begin_tsv'
print 'linkout\tACLANT\t\t%s\t\t' % key
print 'type\tINCONF'
print 'end_tsv'
print 'begin_bibtex'
print bib
print 'end_bibtex'
print 'status\tok'
