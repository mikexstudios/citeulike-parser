#!/usr/bin/python2.4

# Copyright (c) 2006 Kristinn B. Gylfason <citeulike@askur.org>
# All rights reserved.
#
# This code is derived from software contributed to CiteULike.org
# by
#    Diwaker Gupta
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

import re, sys, urllib2, cookielib 

SERVER_ROOT = 'http://www3.interscience.wiley.com/tools/citex'
GET_COOKIE_STR = '?clienttype=1&subtype=1&mode=1&version=1&id=%s'
DOWNL_REF_STR = '?mode=2&format=%s&type=2&file=%s&exportCitation.x=10&exportCitation.y=7&exportCitation=submit'
PLAIN_TEXT = '1' # use the Wiley "plain text" format
RIS = '2' # there is a hidden option to get the data in RIS format, but the syntax of that data is wrong
UNIX_EOL = '3' # get UNIX style end-of-lines (i.e. '\n')

# regexp to match the article id from the url
ID_REGEXP = r"""abstract/	# begin at abstract/
		(\d*)		# valid article ids contain only digits
		/ABSTRACT"""	# terminate at /ABSTRACT
ID_REGEXP_FLAGS = re.VERBOSE

# error messages
ERR_STR_PREFIX = 'status\terr\t'
ERR_STR_FETCH = 'Unable to fetch the bibliographic data: '
ERR_STR_TRY_AGAIN = 'The server may be down.  Please try later.'
ERR_STR_NO_ID = 'No article identifier found in the URL: '
ERR_STR_REPORT = 'Please report the error to plugins@citeulike.org.'

# dictionary to translate from Wiley "plain text" format the Citeulike TSV format
# it also contains necessary substitution strings to convert the data
PT_TO_TSV = {'AB':('abstract',None),\
		'AD':('address',None),\
		'AU':('author',', ','\nauthor\t'),\
		'US':('url',None),\
		'DOI':('doi',None),\
		'PN':('pn',None),\
		'ON':('on',None),\
		'CP':('copyright',None),\
		'YR':('year',None),\
		'PG':('start_page','-','\nend_page\t'),\
		'NO':('issue',None),\
		'VL':('volume',None),\
		'SO':('journal',None),\
		'TI':('title',None)}
DEFAULT = ('unknown',None) # translate any unknown tags to the string 'unknown'

TSV = 0; # location, in the PT_TO_TSV dictionary, of the TSV string
PATT = 1; # location, in the PT_TO_TSV dictionary, of the string to replace
REPL = 2; # location, in the PT_TO_TSV dictionary, of the replacement string 
NUM_SPLITS = 1 # number of times to split each line into tokens
TAG = 0; # location, in the token tuple, of the "plain text" tag
STR = -1; # location, in the token tuple, of the data string


# read url from std input and get rid of the newline at the end
url = sys.stdin.readline().strip()

# parse the article id from the url and exit gracefully if not found
id_match  = re.search(ID_REGEXP, url, ID_REGEXP_FLAGS)
if not id_match:
	print ERR_STR_PREFIX + ERR_STR_NO_ID + url + '.  ' + ERR_STR_REPORT
	sys.exit(1)

article_id = id_match.group(1)

# Wiley likes to give us cookies to keep track of what we are doing
cj = cookielib.CookieJar()
opener = urllib2.build_opener(urllib2.HTTPCookieProcessor(cj))

# feed the cookie monster ;-) 
# (we need to have a session cookie before we can fetch the entry)
try:
	f = opener.open(SERVER_ROOT + GET_COOKIE_STR % article_id)
except:
	print ERR_STR_PREFIX + ERR_STR_FETCH + url + '.  ' + ERR_STR_TRY_AGAIN
	sys.exit(1)

# fetch the entry for the article_id and exit gracefully in case of trouble
try:
	f = opener.open(SERVER_ROOT + DOWNL_REF_STR % (PLAIN_TEXT, UNIX_EOL))
except:
	print ERR_STR_PREFIX + ERR_STR_FETCH + url + '.  ' + ERR_STR_TRY_AGAIN
	sys.exit(1)

entry = f.read().strip()

# translate the "plain text" into TSV
tsv_str = ''
entry_dict = {}
for line in entry.splitlines():
	# split each line into two tokens (tag and data)
	tokens = line.strip().split(': ',NUM_SPLITS)
	# fetch the replacement tuple for that tag
	rep_sec = PT_TO_TSV.get(tokens[TAG],DEFAULT)
	# process the data string (if required)
	if rep_sec[PATT]:
		tokens[STR] = tokens[STR].replace(rep_sec[PATT],rep_sec[REPL])
	# accumulate the results
	tsv_str = tsv_str + rep_sec[TSV] + '\t' + tokens[STR] + '\n'
	# also save the data in a dictionary
	entry_dict[rep_sec[TSV]] = tokens[STR]


# print the results
print "begin_tsv"
print "linkout\tWILEY\t%s\t\t\t" % (article_id)
if entry_dict.get('doi'):
	print "linkout\tDOI\t\t%s\t\t" % entry_dict['doi']
print "type\tJOUR"
print tsv_str,
print "end_tsv"
print "status\tok"
