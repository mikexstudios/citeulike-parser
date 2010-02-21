from urlparse import urlparse
import sys
import cgi

def bail(msg):
	print "status\terr\t", msg
	sys.exit(1)

def urlparams(url):
	ret = {}
	for (key,val) in cgi.parse_qsl(urlparse(url)[4]):
		ret[key.lower()]=val
	return ret
