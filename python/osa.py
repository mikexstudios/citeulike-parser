#!/usr/bin/env python

# Copyright (c) 2007 Kristinn B. Gylfason <citeulike@askur.org>,
#                    Richard Cameron <richard@citeulike.org>

# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation, version 2 of the License.

# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
# details.

# You should have received a copy of the GNU General Public License along with
# this program.  If not, see <http://www.gnu.org/licenses/>.

import sys, urllib, urllib2, urlparse, cgi, re, mechanize, codecs
from BeautifulSoup import BeautifulSoup
import html5lib
from html5lib import treebuilders


RIS_SERVER_ROOT = \
        'http://www.opticsinfobase.org/custom_tags/IB_Download_Citations.cfm'
ris_server_post_data = {'articles':'', 'ArticleAction':'save_endnote2'}
QUERY=4;

# error messages
ERR_STR_PREFIX = 'status\terr\t'
ERR_STR_FETCH = 'Unable to fetch the bibliographic data: '
ERR_STR_TRY_AGAIN = 'The server may be down.  Please try later.'
ERR_STR_NO_KEYS = 'Could not extract atricle details from the URL: '
ERR_STR_REPORT = 'Please report the error to plugins@citeulike.org.'


# read url from std input an get rid of the newline at the end
# sys.stdout = codecs.getwriter('utf-8')(sys.stdout)
url = sys.stdin.readline().strip()

# parse the article details from the url
src_query = cgi.parse_qs(urlparse.urlparse(url)[QUERY])

# fetch the page the user is looking at
br = mechanize.Browser()
br.set_handle_robots(False)
try:
    br.open(url)
except:
    print ERR_STR_PREFIX + ERR_STR_FETCH + url + '.  ' + ERR_STR_TRY_AGAIN
    sys.exit(1)

# get page (the meta tag lies about the encoding)
page = unicode(br.response().read(), encoding="utf-8").replace("iso-8859-1", "utf-8")

# parse the HTML
parser = html5lib.HTMLParser(tree=treebuilders.getTreeBuilder("beautifulsoup"))
soup = parser.parse(page)

#soup = BeautifulSoup(page)
# print soup.prettify()
# if the user came from a page with an article id in the url we use
# that directly in the RIS query
if src_query.has_key('id'):
    article_id = int(src_query['id'][0])
    ris_server_post_data['articles'] = article_id
# otherwize we need to get the id from the page the user is looking at
else:
    article_id_metadata = soup.findAll(name='input', attrs={'name':'articles'})
#    print soup.findAll(name='input')
    article_id = article_id_metadata[0]['value']
    ris_server_post_data['articles'] = article_id
    try:
        # find the article id in the export form
        article_id_metadata = soup.findAll(name='input', attrs={'name':'articles'})
        article_id = article_id_metadata[0]['value']
        ris_server_post_data['articles'] = article_id
    except:
        print ERR_STR_PREFIX + ERR_STR_NO_KEYS + url + '.  ' + ERR_STR_REPORT
        sys.exit(1)

# fetch the RIS entry for the article and exit gracefully in case of trouble
query = urllib.urlencode(ris_server_post_data)
try:
    ris_entry = urllib2.urlopen(RIS_SERVER_ROOT,query).read().strip()
except:
    print ERR_STR_PREFIX + ERR_STR_FETCH + url + '.  ' \
            + ERR_STR_TRY_AGAIN
    raise

# look for an abstract in the Dublin Core metadata in the HTML head
abstract_metadata = soup.findAll(name='meta', attrs={'name':'dc.description'})
if len(abstract_metadata):
    abstract = abstract_metadata[0]['content']
    # clean out whitespace and newlines
    abstract = ' '.join([s.strip() for s in abstract.split('\n')]).strip()
else:
    abstract = None

# look for a DOI in the Dublin Core metadata in the HTML head
doi = ''
doi_metadata = soup.findAll('meta', attrs={'name':'dc.identifier'})
if len(doi_metadata):
    doi_match  = re.search(r'doi:(10\.[^/]+/.+)', doi_metadata[0]['content'], re.IGNORECASE)
    if doi_match:
        doi = doi_match.group(1).strip()

# print the results
print "begin_tsv"
print "linkout\tOSA\t%s\t\t\t" % article_id
if doi:
    print "linkout\tDOI\t\t%s\t\t" % (doi)
    print "doi\t" + doi
if abstract:
    print "abstract\t%s" % abstract.encode("utf-8")
print "end_tsv"
print "begin_ris"
print ris_entry
print "end_ris"
print "status\tok"
