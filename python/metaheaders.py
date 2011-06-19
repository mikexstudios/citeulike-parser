#!/usr/bin/env python2.6
import lxml.html, re

class InvalidArguments(Exception):
	pass

class MetaHeaders:

	def __init__(self, url=None, page=None,name='name',content='content'):
		if page:
			self.root = lxml.html.document_fromstring(page)
		elif url:
			self.root = lxml.html.parse(url).getroot()
		else:
			raise InvalidArguments, "Need a URL or an HTML page"
		meta = {}
		for m in self.root.cssselect("meta"):
			attr=m.attrib
			if attr.has_key(name) and attr.has_key(content) and attr[content] != "":
				k = attr[name]
				v = attr[content]
				if not meta.has_key(k):
					meta[k] = []
				meta[k].append(v)
		self.meta = meta

	def get_item(self, k):
		if self.meta.has_key(k):
			return self.meta[k][0]
		else:
			return None

	def get_multi_item(self, k):
		if self.meta.has_key(k):
			return self.meta[k]
		else:
			return None

	def print_item(self, entry, key):
		el = self.get_multi_item(key)
		if not el:
			return
		for e in el:
			print "%s\t%s" % (entry, e)

	def print_date(self, key):
		date = self.get_item(key)
		if not date:
			return

		year = None
		month = None
		day = None

		m = re.match(r'(\d\d\d\d)(?:[-/])(\d+)(?:[-/])(\d+)', date)
		if m:
			year = m.group(1)
			month = m.group(2)
			day = m.group(3)

		if not year:
			m = re.match(r'(\d\d\d\d)(?:[-/])(\d+)', date)
			if m:
				year = m.group(1)
				month = m.group(2)

		if not year:
			m = re.match(r'(\d\d\d\d)', date)
			if m:
				year = m.group(1)

		if year:
			print "year\t%s" % year
		if month:
			print "month\t%s" % month
		if day:
			print "day\t%s" % day




def test():
	url = "http://ieeexplore.ieee.org/xpl/freeabs_all.jsp?arnumber=4755987"
	print "getting %s " % url

	metaheaders = MetaHeaders(url=url)

	for (k,v) in metaheaders.meta.items():
		print "%s = %s" % (k,v)

	print "===============\nRepeat with manual fetch"
	from urllib2 import urlopen

	page = urlopen(url).read()
	metaheaders = MetaHeaders(page=page)

	for (k,v) in metaheaders.meta.items():
		print "%s = %s" % (k,v)




if __name__ == '__main__':
	test()
