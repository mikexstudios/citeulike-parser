#!/usr/bin/env python

import re, sys, urllib2, cookielib
from urlparse import urlparse
from urllib import urlencode
from urllib2 import urlopen


# error messages (taken from iop.py)
ERR_STR_PREFIX = 'status\terr\t'
ERR_STR_FETCH = 'Unable to fetch the page: '
ERR_STR_TRY_AGAIN = 'The server may be down.  Please try later.'
ERR_STR_NO_DOI = 'No document object identifier found on the page: '
ERR_STR_NO_BIBTEX = 'No BibTeX entry found for the DOI: '
ERR_STR_NO_URL = 'No URL found in the BibTeX entry for the DOI: '
ERR_STR_REPORT = 'Please report the error to plugins@citeulike.org.'

# read url from std input
url = sys.stdin.readline()

# get rid of the newline at the end
url = url.strip()

cookie_jar = cookielib.CookieJar()

handlers = []
if "--debug" in sys.argv:
	handlers.append( urllib2.HTTPHandler(debuglevel=True) )
handlers.append( urllib2.HTTPCookieProcessor(cookie_jar) )

opener=urllib2.build_opener(*handlers)
opener.addheaders = [('User-agent', 'lwp-request/5.810')]
urllib2.install_opener(opener)

# we'll be given a url of the form http://prola.aps.org/abstract/PRA/v18/i3/p787_1
#  http://prola.aps.org/abstract/journal/volume/issue/page
# the ris resource is located at http://prola.aps.org/export/___/v__/i__/p__?type=ris
# use type=bibtex for bibtex 
# should we prefer one to the other?

parsed_url = urlparse(url)

host = 'http://'+ parsed_url.netloc

address = url.split('abstract')[1]

risurl = host +'/export' + address + '?type=ris'
try:
	f = urlopen(risurl);
except:
	print ERR_STR_PREFIX + ERR_STR_FETCH + risurl + '.  ' + ERR_STR_TRY_AGAIN
	sys.exit(1)
ris = f.read()

#okay so that handles most of it  but we still need to get the actual title of the journal,
# and we need to find the abstract if it has one.
absurl = host +'/abstract' + address
try:
	f = urllib2.urlopen(absurl)
except:
	print ERR_STR_PREFIX + ERR_STR_FETCH + absurl + '.  ' + ERR_STR_TRY_AGAIN
	sys.exit(1)
content = f.read()

match = re.search(r"""aps-abstractbox\s*aps-mediumtext">\s*<p>(.*)</p><br\s/>""", content, re.DOTALL)
abstract = ''
if match:
	# strip HTML tags (taken from iop.py)
	from sgmllib import SGMLParser
	class XMLJustText (SGMLParser):
		just_text = ''
		def handle_data (self,data):
			self.just_text = self.just_text + ' ' + data

	parser = XMLJustText()
	parser.feed(match.group(1))
	abstract = parser.just_text.replace(',',';').strip()

# We would much much rather extract the DOI from the ris feed, since it has a
# much more std structure, (that isn't as subject to change as the page conent.
# I don't ever expect that we should get to the else clause.  If the re is
# going to fail, we've probably failed to get the ris earlier.

match = re.search(r"""^ID\s*-\s*(10\..*)""", ris, re.MULTILINE)
if match:
	doi = match.group(1)
else:
	print ERR_STR_PREFIX + ERR_STR_NO_DOI + absurl + '.  ' + ERR_STR_REPORT
	sys.exit(1)

#We can look at the letter code in the address (/address/xxxxx/) 
#to get the journal name.
#Journal  	URL
#Phys. Rev. A	http://pra.aps.org/ PRA
#Phys. Rev. B	http://prb.aps.org/ PRB
#Phys. Rev. C	http://prc.aps.org/ PRC
#Phys. Rev. D	http://prd.aps.org/ PRD
#Phys. Rev. E	http://pre.aps.org/ PRE
#Phys. Rev. Lett.	http://prl.aps.org/ PRL
#Phys. Rev. ST Phys. Educ. Res.	http://prst-per.aps.org/ PRSTPER
#Phys. Rev. ST Accel. Beams	http://prst-ab.aps.org/ PRSTAB
#Rev. Mod. Phys.	http://rmp.aps.org/ RMP
#PROLA Archive	http://prola.aps.org/ PR
# ??? PRI

journal_key = address.split("/")[1]
	
journalmap = {'PRA' : 'Physical Review A',
              'PRB' : 'Physical Review B',
              'PRC' : 'Physical Review C',
              'PRD' : 'Physical Review D',
              'PRE' : 'Physical Review E',
              'PRL' : 'Physical Review Letters',
              'PRI' : 'Physical Review (Series I)',
              'PR' : 'Physical Review Online Archive (Prola)',
              'RMP' : 'Reviews of Modern Physics',
              'PRSTAB' : 'Physical Review Special Topics - Accelerators and Beams',
              'PRSTPER' : 'Phys. Rev. ST Phys. Educ. Res.'
             }
journal = journalmap[journal_key]
#try:
#	journal = journalmap[address[1:4]]
#except KeyError:
#	journal = "APS Journal"
 
print 'begin_tsv'
print 'journal\t' + journal
if abstract:
	print 'abstract\t' + abstract
print "linkout\tPROLA\t\t%s\t\t" % (address[1:])
print "linkout\tDOI\t\t%s\t\t" % (doi)
print 'doi\t' + doi
print 'end_tsv'
print 'begin_ris'
print ris
print 'end_ris'
print 'status\tok'
	
