from urlparse import urlparse
import sys

def bail(msg):
	print "status\terr\t", msg
	sys.exit(1)

def urlparams(url):
	ret = {}
	for key, value in [i.split('=') for i in urlparse(url)[4].split('&')]:
		ret[key.lower()]=value
	return ret
