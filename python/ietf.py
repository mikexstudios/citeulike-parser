#!/usr/bin/env python2
"""
CiteULike scraper for IETF and RFC-Editor URLs.
Copyright (c) 2011, Olivier Mehani <shtrom-cul@ssji.net>
All rights reserved.

$Id$
Parse documents at tools.ietf.org and rfc-editor.org to
extract scholarly metadata and format it according to draft-carpenter-rfc-citation-recs-01

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions
are met:
1. Redistributions of source code must retain the above copyright notice, this
list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation
and/or other materials provided with the distribution.
3. Neither the name of Olivier Mehani nor the names of its contributors
may be used to endorse or promote products derived from this software
without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.

"""
import re
from urllib2 import urlopen
import lxml.html
import datetime

import metaheaders

__version__ = '$Revision$'

CUL_STATUS_OK               = 'ok'
CUL_STATUS_ERR              = 'err'
CUL_STATUS_REDIRECT         = 'redirect'
CUL_STATUS_NOT_INTERESTED   = 'not_interested'

TYPE_NONE   = 0
TYPE_RFC    = 1
TYPE_DRAFT  = 2


class IetfDocument:
    rfcid_re    = "rfc[0-9]*"
    # We are not_interested with drafts without version number,
    # as I-D citation are incomplete without them
    # Doing this, we enforce good practice
    draftid_re    = "draft-[-a-zA-Z0-9]+-[0-9]+"
    rfced_re    = "rfc-editor.org"
    rfced_doc_re= rfced_re + "/(in-notes/)?(rfc|internet-drafts)/(?P<doc_id>" +\
            rfcid_re + "|" + draftid_re + ").txt"
    ietf_re     = "tools.ietf.org"
    ietf_doc_re = ietf_re + "/(rfc|id|html|pdf)/(?P<doc_id>" + rfcid_re + "|" +\
            draftid_re + ")"

    url         = None
    redirect_url = None # Currently unused
    errmsg      = "Undefined error"
    status      = CUL_STATUS_NOT_INTERESTED
    tsv         = { }
    bibtex      = None

    def __init__(self, url):
        doc_id = None

        m = re.search(self.rfced_doc_re, url)
        if m is None:
            m = re.search(self.ietf_doc_re, url)

        if m is not None:
            doc_id = m.group('doc_id')
            self.url = self.canonical_url(doc_id)

            if self.url is None:
                self.status = CUL_STATUS_ERR
            else:
                if self.document_type(doc_id) == TYPE_RFC:
                    self.tsv['issue']          = self.rfc_number(doc_id)
                    self.tsv['linkout']        = "\t".join(("RFC", "", doc_id,
                        "", ""))

                    self.tsv['how_published']  = "Internet Requests for Comment"
                    self.tsv['institution']    = "RFC Editor"
                    self.tsv['issn']           = "2070-1721"
                    self.tsv['publisher']      = "RFC Editor"

                    self.bibtex = "@TECHREP{%s, type = {RFC}, key = {RFC%s}}" %\
                            (doc_id, self.rfc_number(doc_id))

                    self.status = CUL_STATUS_OK
                elif self.document_type(doc_id) == TYPE_DRAFT:
                    self.tsv['issue']          = doc_id + ".txt"
                    # We don't give the .txt to linkout as we want to easily
                    # format links to HTML pages on tools.ietf.org
                    self.tsv['linkout']        = "\t".join(("IDRAFT", "", doc_id,
                        "", ""))

                    self.tsv['how_published']  = "Working Draft"
                    self.tsv['institution']    = "IETF Secretariat"
                    self.tsv['publisher']      = "IETF Secretariat"

                    self.bibtex = "@TECHREP{%s, type = {Internet-Draft}}" % \
                            self.tsv['issue']

                    self.status = CUL_STATUS_OK
                else:
                    self.errmsg = "Unknown document type"
                    self.status = CUL_STATUS_ERR

                self.tsv['address']        = "Fremont, CA, USA"
                self.tsv['type']           = "REP"

                abstract, author, day, month, title, year = \
                        self.parse_url(self.url)
                self.tsv['abstract']       = abstract
                self.tsv['author']         = author
                self.tsv['day']            = day
                self.tsv['month']          = month
                self.tsv['title']          = title
                self.tsv['year']           = year

    @classmethod
    def document_type(cls, doc_id):
        if re.match(cls.rfcid_re, doc_id):
            return TYPE_RFC
        elif re.match(cls.draftid_re, doc_id):
            return TYPE_DRAFT
        return TYPE_NONE

    @staticmethod
    def canonical_url(doc_id):
        return "http://tools.ietf.org/html/" + doc_id.strip(".txt")

    @staticmethod
    def rfc_number(doc_id):
        return doc_id[3:]

    # The URL/HTML parsing is largely inspired from naturepreceedings.py
    # Fortunately, the IETF has HTML-valid pages
    @staticmethod
    def parse_url(url):
        page = urlopen(url).read()
        headers = metaheaders.MetaHeaders(page=page)

        author = headers.get_multi_item("DC.Creator")

        title     = headers.get_item("DC.Title")
        # Try to extract the tile for those documents without RDF markup
        if title == None:
            for div in headers.root.cssselect("div.articleText"):
                title = div.xpath("string()")
                break

        date      =  headers.get_item("DC.Date.Issued")
        day, month, year = IetfDocument.parse_date(date)

        abstract  = headers.get_item("DC.Description.Abstract")
        if abstract is not None:
            abstract = abstract.replace("\\n", " ")
            abstract.strip()

        return (abstract, author, day, month, title, year)

    @staticmethod
    def parse_date(date):
        # Try our best to find the date format
        try:
            d = datetime.datetime.strptime(date,"%Y-%m-%d")
            return (str(d.day), str(d.month), str(d.year))
        except:
            pass
        try:
            d = datetime.datetime.strptime(date,"%B, %Y")
            return (None, str(d.month), str(d.year))
        except:
            return (None,) * 3

    def __str__(self):
        str = ""
        if len(self.tsv) > 0:
            str += "begin_tsv\n"
            for k in self.tsv.keys():
                if self.tsv[k] is not None:
                    if k == "author":
                        for auth in self.tsv[k]:
                            str += k + "	" + auth + "\n"
                    else:
                        str += k + "	" + self.tsv[k] + "\n"
            str += "end_tsv\n"
            if self.bibtex is not None:
                str += "begin_bibtex\n"
                str += self.bibtex + "\n"
                str += "end_bibtex\n"
        str += "status\t" + self.status
        if self.status == CUL_STATUS_REDIRECT:
            str += "\t" + self.redirect_url
        elif self.status == CUL_STATUS_ERR:
            str += "\t" + self.errmsg
        return str

    def __repr__(self):
        return cls.__name__ + "(" + self.url + ")"

if __name__ == '__main__':
    import sys
    print(IetfDocument(sys.stdin.readline().strip()))

# vim: expandtab
