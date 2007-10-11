#!/usr/bin/env python

# Copyright (c) 2007 Kristinn B. Gylfason <citeulike@askur.org>

# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation, version 2 of the License.  

# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
# details.

# You should have received a copy of the GNU General Public License along with
# this program.  If not, see <http://www.gnu.org/licenses/>.

import sys, urllib, urllib2, urlparse, cgi, re

RIS_SERVER_ROOT = \
        'http://www.opticsinfobase.org/custom_tags/IB_Download_Citations.cfm'
#OSA_DOI_PREFIX = '10.1364'
#IEEE_DOI_PREFIX = '10.1109'
ris_server_post_data = {'articles':'', 'ArticleAction':'save_endnote2'}
QUERY=4;

# error messages
ERR_STR_PREFIX = 'status\terr\t'
ERR_STR_FETCH = 'Unable to fetch the bibliographic data: '
ERR_STR_TRY_AGAIN = 'The server may be down.  Please try later.'
ERR_STR_NO_KEYS = 'Could not extract atricle details from the URL: '
ERR_STR_REPORT = 'Please report the error to plugins@citeulike.org.'

def fetch(url, query=None):
    try:
        params = [x for x in [url, query] if x is not None]
        return urllib2.urlopen(*params).read().strip()
    except:
	print ERR_STR_PREFIX + ERR_STR_FETCH + url + '.  ' \
                + ERR_STR_TRY_AGAIN
	raise


# read url from std input an get rid of the newline at the end
url = sys.stdin.readline().strip()

# parse the article details from the url 
src_query = cgi.parse_qs(urlparse.urlparse(url)[QUERY])

# if the user came from a page with an article id in the url we use
# that directly in the RIS query
if src_query.has_key('id'):
    article_id = int(src_query['id'][0])
    ris_server_post_data['articles'] = article_id
else:
# otherwize we need to get the id from the page the user is looking at
    from mechanize import Browser
    br = Browser()
    br.set_handle_robots(False)
    try:
        br.open(url)
    except:
        print ERR_STR_PREFIX + ERR_STR_FETCH + url + '.  ' + ERR_STR_TRY_AGAIN
        sys.exit(1)

    try:
        # find the article id in the export form
        br.select_form(predicate=lambda form: \
            'articles' in [ctrl.name for ctrl in form.controls])
        article_id = int(br['articles'])
        ris_server_post_data['articles'] = article_id
    except:
        print ERR_STR_PREFIX + ERR_STR_NO_KEYS + url + '.  ' + ERR_STR_REPORT
        sys.exit(1)

# fetch the RIS entry for the article and exit gracefully in case of trouble
query = urllib.urlencode(ris_server_post_data)
ris_entry = fetch(RIS_SERVER_ROOT,query)

# Grab the abstract from the HTML
abstract_page = fetch("http://www.opticsinfobase.org/abstract.cfm?id=%d" % article_id)
m = re.search( r'<p><strong>Abstract</strong><br/>\s+(<p><a.*?</p>)?(.*?)</p>', abstract_page, re.DOTALL)
if m:
    abstract = m.group(2).strip()
else:
    abstract = None

# print the results
print "begin_tsv"
print "linkout\tOSA\t%d\t\t\t" % article_id
if abstract is not None:
    print "abstract\t%s" % abstract
#print "linkout\tDOI\t\t%s\t\t" % (doi)
#print "doi\t" + doi
print "end_tsv"
print "begin_ris"
print ris_entry
print "end_ris"
print "status\tok"
