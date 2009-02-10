#!/usr/bin/env python
# parse a PLoS for CiteULike.org
# fetch the RIS citation provided by PLoS journals
# C.Ladroue
# mods by Fergus Gallagher/CiteULike

from urllib2 import urlopen
from urlparse import urlparse
import sys, re, urllib
from utils import decode_entities

def url2doi(url):
	""" Look for any instance of a DOI in the URL """
	urluq = urllib.unquote(url)
	m = re.search('10\.1371/[^/&]+', urluq)
	if m:
		return m.group(0)
	return None

def fetch_pmid(hostname, doi):
	url = "http://%s/perlserv/?request=get-document&doi=%s" % (hostname,urllib.quote(doi))
	page = urlopen(url).read()
	
	m = re.search(r'=([0-9]+)&dopt=Citation" class="ncbi" title="View PubMed Record', page)
	if m:
		return int(m.group(1))
	return None

def fetch_record(url):
	hostname = urlparse(url)[1]
	doi = url2doi(url)

	if '/perlserv' in url:
		# It's definitely an old style one
		return fetch_old_ris(hostname, doi)

	(type, record) = fetch_new_ris(hostname, doi)
	if re.search('\s*TY  - ', record):
		return (type, record)

	# See if it's an old style "perlserv" record just in case
	return fetch_old_ris(hostname, doi)
	

def fetch_new_ris(hostname, doi):
	
	url = "http://%s/article/getRisCitation.action?articleURI=info:doi/%s" % (hostname, urllib.quote(doi))

	record = unicode(urlopen(url).read().strip(), "utf8")

	record = record.replace("10.1371%2F", "10.1371/")
	record = decode_entities(record)
	return ("ris", record)

def fetch_old_ris(hostname, doi):
	""" Fetch the older style RIS record """
	index_url = "http://%s/perlserv/?request=cite-builder&doi=%s" % (hostname, urllib.quote(doi))
	index_page = urlopen(index_url).read()
	m = re.search(r'<a href="([^"]+)">Reference Manager Format</a>', index_page)

	if not m:
		bail("Failed to fetch RIS download in %s" % index_url)

	ris_url = "http://%s/perlserv/%s" % (hostname, decode_entities(m.group(1)))
	ris = unicode(urlopen(ris_url).read().strip(), "utf8")
	return ("ris", decode_entities(ris.replace("10.1371%2F", "10.1371/")))

def emit(*k):
	print u"\t".join([unicode(x) for x in k]).encode("utf8")

def bail(msg):
	emit("status", "err", msg)
	sys.exit(0)


def main():
	url = sys.stdin.readline().strip()
	hostname = urlparse(url)[1]

	doi = url2doi(url)

	if not doi:
		bail("Can't find a DOI in the URL. Are you definitely looking at a single article on PLoS?")
		
	try:
		(type, record) = fetch_record(url)
	except:
		emit("status", "err", "Failed to fetch the BibTeX or RIS record from the PLoS site")
		raise

	emit("begin_tsv")

	# Use the DOI as the linkout
	emit("linkout", "DOI", "", doi, "", "")

	if "/perlserv" in url:
		# See if we have a pubmed ID
		pmid = fetch_pmid(hostname, doi)
		if pmid:
			emit("linkout", "PMID", "%d" % pmid, "", "", "")

	emit("end_tsv")

	# Push out the RIS record. CiteULike will figure out everything else from that.
	emit("begin_%s" % type)
	emit(record)
	emit("end_%s" % type)

	emit("status", "ok")

if __name__=="__main__":
	main()
