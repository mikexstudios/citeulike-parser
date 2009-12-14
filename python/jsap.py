#!/usr/bin/env python

# Copyright (c) 2009 Kristinn B. Gylfason <citeulike@askur.org>,

# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation, version 2 of the License.

# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
# details.

# You should have received a copy of the GNU General Public License along with
# this program.  If not, see <http://www.gnu.org/licenses/>.

import sys, urllib2

CITATION_SERVER_ROOT = 'http://%(lc_journal)s.ipap.jp/cgi-bin/dumparticle'
REQ_STR = '?mode=bibtex&journal=%(journal)s&volume=%(volume)s&page=%(page)s'
REQ_DATA = {}

# error messages
ERR_STR_PREFIX = 'status\terr\t'
ERR_STR_FETCH = 'Unable to fetch the bibliographic data: '
ERR_STR_TRY_AGAIN = 'The server may be down.  Please try later.'
ERR_STR_NO_KEYS = 'Could not extract atricle details from the URL: '
ERR_STR_REPORT = 'Please report the error to plugins@citeulike.org.'

# read url from std input an get rid of the newline at the end
url = sys.stdin.readline().strip()

# parse the article info from the URL
split_url = url.split('/')
# check if the data conforms to the expected URL format
if (len(split_url) != 7) or (split_url[3].split('?')[0] != 'link'):
    print ERR_STR_PREFIX + ERR_STR_NO_KEYS + url + '.  ' + ERR_STR_REPORT
    raise Exception

REQ_DATA['journal'] = split_url[3].split('?')[1]
REQ_DATA['lc_journal'] = REQ_DATA['journal'].lower()
REQ_DATA['volume'] = split_url[4]
REQ_DATA['page'] = split_url[5]

# fetch the bibligraphic data
try:
    f = urllib2.urlopen(CITATION_SERVER_ROOT % REQ_DATA + REQ_STR % REQ_DATA)
except:
    print ERR_STR_PREFIX + ERR_STR_FETCH + CITATION_SERVER_ROOT + '.  ' + ERR_STR_TRY_AGAIN
    raise Exception
entry = f.read().strip()

# print the results
print "begin_tsv"
print "linkout\tJSAP\t%(page)s\t%(lc_journal)s\t%(volume)s\t%(journal)s" % REQ_DATA
print "end_tsv"
print "begin_bibtex"
print entry
print "end_bibtex"
print "status\tok"
