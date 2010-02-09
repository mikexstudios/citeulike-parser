#!/usr/bin/env python
# coding: utf-8

# Fetch EndNote citation from Daum reference search
# Seo Sanghyeon

import re, urllib, sys
import socket

socket.setdefaulttimeout(15)


def url_to_docid(url):
    match = re.search(r'ref.daum.net/item/(\d+)', url)
    if match:
        return int(match.group(1))

def grab_enw(docid):
    url = 'http://ref.daum.net/export.daum?docid=%d&exptype=endnote' % docid
    enw = urllib.urlopen(url).read().decode('cp949')
    return enw

def parse_date(date):
    match = re.match(r'(\d{4})-(\d{2})', date)
    if match:
        year, month = match.groups()
        month = str(int(month))
        yield 'year', year
        yield 'month', month
        return
    match = re.match(r'(\d{4})', date)
    if match:
        year, = match.groups()
        yield 'year', year
        return

def parse_page(page):
    match = re.match(r'pp\.(\d+)[-~](\d+)', page)
    if match:
        start, end = match.groups()
        yield 'start_page', start
        yield 'end_page', end
        return

enw_map = {
    'D': parse_date,
    'I': 'publisher',
    'J': 'journal',
    'N': 'issue',
    'P': parse_page,
    'T': 'title',
    'V': 'volume',
    'X': 'abstract',
}

def parse_enw(enw):
    for line in enw.splitlines():
        match = re.match(r'%(.) - (.*)', line)
        if not match:
            continue
        key, value = match.groups()
        if key == 'X':
            value = value.strip()
        if key not in enw_map:
            continue
        mapped_key = enw_map[key]
        if isinstance(mapped_key, basestring):
            field = mapped_key
            yield field, value
        else:
            handler = mapped_key
            for field, value in handler(value):
                yield field, value

def main(url):
    docid = url_to_docid(url)
    enw = grab_enw(docid)

    print 'begin_tsv'
    print 'type\tJOUR'
    print 'linkout\tDAUM\t%d\t\t\t' % docid
    for field, value in parse_enw(enw):
        value = value.encode('utf-8')
        print '%s\t%s' % (field, value)
    print 'end_tsv'
    print 'status\tok'

if __name__ == '__main__':
    url = sys.stdin.readline().strip()
    main(url)
