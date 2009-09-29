#!/usr/bin/python2.5
# parse a JstatSoft URL for CiteULike.org
# URL is expected to be of the form http:\/\/www\.jstatsoft\.org\/[a-z][0-9]+\/[a-z][0-9]+
# Append /bibtex to the url, parse out the bibtex and pass it on.
# Also parses the abstract if any and linkouts to the pdf and the original paper.
# C.Ladroue

import urllib
import sys
import re

def main():
	# Append bibtex to the url
	url = sys.stdin.readline().strip()
	bibtexurl=url+'/bibtex'

	match  = re.search(r'http://www\.jstatsoft\.org/([a-z][0-9]+)/([a-z][0-9]+)', url)
	if not match:
		print "status\terr\tCannot parse/%s" % url
		sys.exit(1)

	print "begin_tsv"
	print "linkout\tJSS\t\t%s\t\t%s" % (match.group(1),match.group(2))
	print "end_tsv"
	print "\nbegin_bibtex"

	pat=re.compile(r'(?s)<td class="label">Abstract:<\/td>(.*)<td [^>]+><p>(.*)<\/p>')

	try:
		# Download the abstract file
		instream=urllib.urlopen(url)
		content=instream.read()
		instream.close()

		# Define the pattern
		pat=re.compile(r'(?s)<td class="label">Abstract: <\/td>(.*)<td [^>]+><p>(.*)<\/p>')

		# Parse the abstract
		abstract=pat.search(content).groups()
		abstract=abstract[1]

	except Exception,err:
		abstract=''

	abstract= "\n  Abstract =    \""+abstract+"\","
	try:
		# Download the bibtex-containing file
		instream=urllib.urlopen(bibtexurl)
		content=instream.read()
		instream.close()


		# Define the pattern.
		# Note that the html is malformed: it doesn't close with </pre> but with <pre>.
		# I add a /pre in anticipation that they fix it at a later date.
		pat=re.compile(r'(?s)<pre class="bibtex"[^>]+>(.*)<\/?pre>')

		# Parse the bibtex
		info=pat.search(content).groups()
		info=info[0]
		tmp=info.partition(",");

		#insert abstract
		print tmp[0]+tmp[1]+abstract+tmp[2]

	except Exception,err:
		print "\nend_bibtex"
		print "\nstatus\terr\tThe plugin has not been able to reach the BibTex citation provided by JStatSoft."
		sys.exit()

	print "\nend_bibtex"
	print "\nstatus\tok"

if __name__=="__main__":
	main()
