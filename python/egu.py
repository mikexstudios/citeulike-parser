#!/usr/bin/env python
# parse EGU journal html and return bibliographic information
# (c) Jan Cermak, 2009, jan.cermak@env.ethz.ch
# in part following agu.py and http://www.boddie.org.uk/

import re,sys
from urllib2 import urlopen
from urlparse import urlparse
import sgmllib


class ParseException(Exception):
    pass


class MyParser(sgmllib.SGMLParser):
    "A simple parser class as given on http://www.boddie.org.uk/python/HTML.html"
    def parse(self, s):
        "Parse the given string 's'."
        self.feed(s)
        self.close()
    def __init__(self, verbose=0):
        "Initialise an object, passing 'verbose' to the superclass."
        sgmllib.SGMLParser.__init__(self, verbose)
        self.hyperlinks = []
    def start_a(self, attributes):
        "Process a hyperlink and its 'attributes'."
        for name, value in attributes:
            if name == "href":
                self.hyperlinks.append(value)
    def get_hyperlinks(self):
        "Return the list of hyperlinks."
        return self.hyperlinks

def bibTexString(string):
    """Put {} around the first letter of words starting with a capital letter."""
    newstring = ''
    for word in string.split():
        if word.istitle():
            newword = '{' + word[0] + '}' + word[1:]
        else:
            newword = word
        newstring = newstring + newword + ' '
    newstring.strip()   # not working!
    return newstring


def handle(url):
    m = re.match(r'(http://www\.(atmos-chem-phys|clim-past)\.net/[0-9]+/[0-9]+/[0-9]{4}/[[:alpha:]]+-[0-9]+-[0-9]{4}\w*)', url)
#    print m
#    if not m:
#        raise ParseException, "URL not supported %s" % url

    # read page
    page = urlopen(url).read()

    # get base url
    o = urlparse(url)
    if o[0] == 'http':
        urlBase = o[0] + '://' + o[1]
        journalNameUrlComponent = o[1].rstrip('net').rstrip('.').lstrip('www.')
        #journalNameUrlComponent = o[1].rstrip('.net').lstrip('www.')  # produces rubbish
    else:
        urlBase = o[0]
        journalNameUrlComponent = o[0].rstrip('.net').lstrip('http://www.')

    # extract abstract from page
    abstractStart = page.rfind('Abstract.') + 17  # add length of title and tag
    abstractLen = page[abstractStart:].find('</span>')
    abstractEnd = abstractStart + abstractLen
    abstractRaw = page[abstractStart:abstractEnd]
    abstract = abstractRaw.replace('\r\n',' ')

    # find hyperlinks in page
    myparser = MyParser()
    myparser.parse(page)
    links = myparser.get_hyperlinks()

    # find ris and bibtex urls
    risLink = 'None'
    btLink = 'None'
    for link in links:
        if link.rfind('.ris') != -1:
            risLink = link
        elif link.rfind('.bib') != -1:
            btLink = link
    risUrl = urlBase + risLink
    btUrl = urlBase + btLink

    RIS = urlopen(risUrl).read()
    bibTex = urlopen(btUrl).read()

    # extract information from RIS data
    print 'begin_ris'
    authors = []
    for line in RIS.splitlines():
        if line[:2] == 'T1':  # bibtexify title before printing
            newTitle = (bibTexString(line.split('-')[1])).strip()
        elif line[:2] == 'JO':  # don't print journal title, take uabbreviated bibtex version
            pass
        elif line[:2] == 'A1':  # RIS does a bad job on authors, fix
            authorRaw = line.split('-')[1]
            firstNames = authorRaw.split(',')[1].strip()
            lastNames = authorRaw.split(',')[0].strip()
            authorClean = firstNames + ' ' + lastNames
            authors.append(authorClean)
        else:
            print line
        # get some other information
        if line[:2] == 'SP':  # start page, needed for linkout
            startPage = line.split()[2]
        if line[:2] == 'EP':  # end page, needed for linkout
            endPage = line.split()[2]
        if line[:2] == 'VL':  # volume, needed for linkout
            volume = line.split()[2]
        if line[:2] == 'Y1':  # date information, needed in various contexts
            date = line.split()[2]
            year = date.split('/')[0]
            month = int(date.split('/')[1])
            day = int(date.split('/')[2])
    print 'end_ris'

    # now write the rest in tsv code
    print "begin_tsv"

    # print authors
    for author in authors:
        print "author\t%s" % author

    # extract information from bibTex data
    for line in bibTex.splitlines():
        if line.rfind('JOURNAL') != -1:
            journalNameRaw = line.split('=')[1]
            journalName = journalNameRaw.lstrip(' {').rstrip('},')
            print "journal\t%s" % journalName

    # get keys for linkout and spit it back to standard out
    ckey_1 = journalNameUrlComponent
    ikey_1 = volume
    ikey_2 = startPage
    ckey_2 = year   # actually this would be integer, but only 2 ikeys allowed
    print "linkout\tEGU\t%s\t%s\t%s\t%s" % (ikey_1, ckey_1, ikey_2, ckey_2)

    print "title\t%s" % newTitle
    print "abstract\t%s" % abstract
    print "day\t%s" % day
    print "month\t%s" % month
    print "year\t%s" % year
    print "type\tJOUR"
    print "end_tsv"
    print "status\tok"


# get abstract
# output abstract

url = sys.stdin.readline()
url = url.strip()
#url = 'http://www.atmos-chem-phys.net/9/1847/2009/acp-9-1847-2009.html'
handle(url)


#print 'begin_bibtex'
#print 'end_bibtex'

# ris contains more information than BibTex: pdf url is given in addition
#print 'begin_ris'
#print 'end_ris'



#$ echo 'http://www.jstor.org/view/00376752/ap010113/01a00130/0' | ./jstor.tcl
#begin_tsv
#linkout	JSTOR		0037-6752%28198424%291%3A28%3A4%3C533%3AANOMEG%3E2.0.CO%3B2-3
#title	A Note on May Eve, Good Friday, and the Full Moon in Bulgakov's The Master and Margarita
#author	Donald M. Fiene
#journal	The Slavic and East European Journal
#volume	28
#issue	4
#year	1984
#start_page	533
#end_page	537
#type	JOUR
#end_tsv
#status	ok
