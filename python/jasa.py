#!/usr/bin/python

import sys, codecs, cookielib
import urllib2

import metaheaders
from cultools import bail


def get_header(metaheaders, a, b):
	A = metaheaders.get_item(a)
	if A:
		return A
	B = metaheaders.get_item(b)
	if B:
		return B
	return None

url = sys.stdin.readline().strip()

sys.stdout = codecs.getwriter('utf-8')(sys.stdout)

cj = cookielib.CookieJar()
opener = urllib2.build_opener(urllib2.HTTPCookieProcessor(cj))

f = opener.open(url)
page = f.read().strip()

#print page

metaheaders = metaheaders.MetaHeaders(page=page)

#for (k,v) in metaheaders.meta.items():
#	print "%s = %s" % (k,v)

"""
dc.publisher = ['Acoustical Society of America']
dc.description = [u'\nThe scope of this study is to relate the acoustic emission (AE) during rupture of human soft tissue (anterior cruciate ligament, ACL) to the mechanisms leading to its failure. The cumulative AE activity highlights the onset of serious damage, while other parameters, show repeatable tendencies, being well correlated with the tissue\u2019s mechanical behavior. The frequency content of AE signals increases throughout the experiment, while other indices characterize between different modes of failure. Results of this preliminary study show that AE can shed light into the failure process of this tissue, and provide useful data on the ACL reconstruction.\n']
citation_issue = ['6']
citation.issn = ['00014966']
citation_title = ['Rupture of anterior cruciate ligament monitored by acoustic emission']
citation_volume = ['129']
citation_firstpage = ['EL217']
?lastpage


citation_doi = ['doi:10.1121/1.3571537']
dc.creator = ['D. G. Aggelis', 'N. K. Paschos', 'N. M. Barkoula', 'A. S. Paipetis', 'T. E. Matikas', 'A. D. Georgoulis']
"""


key_map = {
	"publisher" : "citation_publisher",
	"abstract" : "description",
	"issue": "citation_issue",
	"issn": "citation.issn",
	"title": "citation_title",
	"volume": "citation_volume",
	"start_page": "citation_firstpage",
	"end_page": "citation_lastpage"
}

doi = metaheaders.get_item("citation_doi")

if not doi:
	bail('Unable to find a DOI')
	sys.exit(0)

doi = doi.replace("doi:","")

print "begin_tsv"
print "linkout\tDOI\t\t%s\t\t" % (doi)
print "type\tJOUR"
print "doi\t" + doi
for f in key_map.keys():
	k = key_map[f]
	v = metaheaders.get_item(k)
	if not v:
		continue
	v = v.strip()
	print "%s\t%s"  % (f,v)

authors = metaheaders.get_multi_item("dc.creator")
if not authors:
	authors = metaheaders.get_multi_item("citation_author")
if authors:
	for a in authors:
		print "author\t%s" % a

if metaheaders.get_item("citation_date"):
	metaheaders.print_date("citation_date")
elif metaheaders.get_item("dc.date"):
	metaheaders.print_date("dc.date")



print "end_tsv"
print "status\tok"


