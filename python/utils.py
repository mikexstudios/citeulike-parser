"""General utilities for writing scrapers for CiteULike in Python"""

import re
from htmlentitydefs import name2codepoint

from BeautifulSoup import BeautifulStoneSoup

def decode_entities(html):
	return unicode(BeautifulStoneSoup(html,convertEntities=BeautifulStoneSoup.HTML_ENTITIES ))

def x_decode_entities(html):
	html = re.sub('&#(\d+);', lambda m: unichr(int(m.group(1))), html)
	html = re.sub('&(%s);' % '|'.join(name2codepoint), lambda m: str(name2codepoint[m.group(1)]), html)
	return html
