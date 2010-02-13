"""General utilities for writing scrapers for CiteULike in Python"""

import time, exceptions, sys, os, signal, re
from htmlentitydefs import name2codepoint

from BeautifulSoup import BeautifulStoneSoup

def decode_entities(html):
	return unicode(BeautifulStoneSoup(html,convertEntities=BeautifulStoneSoup.HTML_ENTITIES ))

def x_decode_entities(html):
	html = re.sub('&#(\d+);', lambda m: unichr(int(m.group(1))), html)
	html = re.sub('&(%s);' % '|'.join(name2codepoint), lambda m: str(name2codepoint[m.group(1)]), html)
	return html

def handleSig(signum, frame):
	sys.exit(0)

def install_io_trap():
	signal.signal(signal.SIGPIPE,handleSig)
	sys.stdout = os.fdopen(sys.stdout.fileno(), 'w', 0)


