#!/usr/bin/env tclsh

#
# Copyright (c) 2005 Richard Cameron, CiteULike.org
# All rights reserved.
#
# This code is derived from software contributed to CiteULike.org
# by
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
# 3. All advertising materials mentioning features or use of this software
#    must display the following acknowledgement:
#        This product includes software developed by
#		 CiteULike <http://www.citeulike.org> and its
#		 contributors.
# 4. Neither the name of CiteULike nor the names of its
#    contributors may be used to endorse or promote products derived
#    from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY CITEULIKE.ORG AND CONTRIBUTORS
# ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
# TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE FOUNDATION OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
#

source util.tcl
set url [gets stdin]

# Try to beat proxies
proc canon_url {url} {
	if {[regexp {http://[^/]*sciencedirect.com[^/]*/(science(\?_ob|/article).*$)} $url -> path]} {
		return "http://www.sciencedirect.com/${path}"
	}
	return ""
}

puts "begin_tsv"

# We've probably got a fulltext or an abstract or something
# Pull it down and take a look at it.
set page [url_get [canon_url $url]]

# Talk about going round the bloody houses. There's an issue with the sciencedirect
# website where if you bookmark a URL and then come back to it later and attempt
# to follow the link to export a citation, it'll ultimately fail with a good old
# "internal error" when you ask for the RIS file.
#
# The workaround is to fetch the article again from its DOI record. Awful.
#
set re "<a href=\"http://dx.doi.org/(\[^\"\]+)\""
if {[regexp $re $page match doi]} {

	puts "linkout\tDOI\t\t$doi\t\t"

	# Only if the DOI points to elsevier..
	if {[string first "10.1016/" $doi]==0} {
		
		# Fetch a "fresh" copy of the page if we can
		set doi_page [url_get "http://dx.doi.org/$doi"]
		
		if {![regexp {cannot be found in the Handle System} $doi_page]} {
			set page $doi_page
		}
		
		# And now there's an even more rediculous hop, which is sometimes SD asks us whether
		# we want to get the article at sciencedirect or some other site. We'll need to follow that link too
		if {[regexp {<a HREF=\"([^\"]+)\">\n			    							Article via\s*\n			    							ScienceDirect</a>} $page -> next_url]} {
			# Idiots have urlencoded the link.
			set next_url [string map [list "&amp;" "&"] $next_url]
			set page [url_get $next_url]
		}
	}
}	

# Look for an export citation link
if {![regexp {<a href="([^"]+)" onmouseover="document.images.'export'.} $page match export_url]} {
	puts stderr $page
	bail "Are you looking at the full text or the summary of the article you're trying to add? Is it possible you tried to post a page containing a list of search results? I can't recognise your page as a ScienceDirect article. Try again when you're looking at the full-text page. It's the one with the full details of the article and a link on the right hand side saying 'Export Citation'"
}

# That gives us something like
# /science?_ob=DownloadURL&_method=confirm&_ArticleListID=221049524&_rdoc=1&_docType=FLA&_acct=C000010021&_version=1&_userid=121749&md5=5cc6c9b143ed2d9b07b54f9f463f027c
# Follow it
set export_page [url_get "http://www.sciencedirect.com$export_url"]



foreach p {_ob _method _ArticleListID _uoikey count _docType _acct _version _userid md5} {
#_acct _userid _docType _ArticleListID encodedHandle _rdoc md5 RETURN_URL
	regexp "<input type=hidden name=$p value=(\[^>\]*)>" $export_page match param($p)
}
set param(_ob) "DownloadURL"
set param(_method) "finish"
set param(format) "cite-abs"
set param(citation-type) "RIS"
set param(JAVASCRIPT_ON) Y
set param(count) 1
set param(x) 11
set param(y) 14

set qry ""
foreach {k} [list _ob _method _acct _userid _docType _ArticleListID _uoikey encodedHandle _rdoc md5 format citation-type x y RETURN_URL] {
	if {[info exists param($k)]} {
		set v $param($k)
		lappend qry "$k=$v"
	}
}

set qry [join $qry "&"]
set target "http://www.sciencedirect.com/science?$qry"
set ris [url_get $target]


if {[regexp {sciencedirect.com[^/]*?/science/article/(.+?)\n} $ris match id]} {
	puts [join [list linkout "SD" "" [string trim $id] "" ""] "\t"]
}

puts "end_tsv"

puts "begin_ris"
puts $ris
puts "end_ris"

puts "status\tok"


