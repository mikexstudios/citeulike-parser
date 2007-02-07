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

if {[regexp {ingentaconnect.com/content/[^/]+/[^/]+/[^/]+/[^/]+/[^/]+$} $url]} {
    bail "It appears you are trying to bookmark an entire issue of a journal. Try navigating to the abstract page for just one article on Ingenta and bookmark that instead (if you're trying to choose which article you want by using the check-boxes on the page then, regrettably, that won't work)."
}

set page [url_get $url]

proc get_meta {page name} {
    set re "<meta name=\"$name\"\[^>\]*content=\"(\[^\"\]*)\"/>"
    set ret ""
    regexp $re $page match ret
    return $ret
}



puts "begin_tsv"
put_tsv title [get_meta $page "DC.title"]
set id [get_meta $page "DC.identifier"]
if {[regexp {^doi:([^/]+/[^/]+$)} $id -> do]} {
    put_linkout DOI "" $doi "" ""
}

set rauthors [get_meta $page "DC.creator"]
foreach author [split $rauthors ";"] {
    # lose the disporder
    set author [regsub {\[\d+\]} $author ""]
    set author [string trim [string map [list "  " " "] $author]]
    put_tsv author $author
}


set issued [get_meta $page "DCTERMS.issued"]
if {[regexp {^(\d+)?\s?(January|February|March|April|May|June|July|August|September|October|November|December) (\d\d\d\d$)} $issued -> ret(day) month ret(year)]} {
    put_tsv month [map_long_month $month]
} else {
    if {[regexp {^(\d\d\d\d)$} $issued -> year]} {
	put_tsv year $year
    }
}

set cite [get_meta $page "DCTERMS.bibliographicCitation"]
if {[regexp {^(.*), (\d+), (\d+), ([0-9-]+)\((\d+)\)$} $cite ->\
	journal volume issue pages]} {
    foreach {first last} [parse_start_end_pages $pages] {}
    if {[info exists first] && $first!=""} {
	put_tsv start_page $first
    }
    if {[info exists last] && $last!=""} {
	put_tsv end_page $last
    }
}

if {[regexp {<p><strong>Abstract:</strong></p>(.*?)</div>} $page -> abstract]} {
    put_tsv abstract [string trim [strip_html_tags $abstract]]
}

if {[regexp "value=\"infobike://(\[^\"\]+)\"/>" $page -> infobike]} {
    put_linkout IBIKE "" $infobike "" ""
}

puts "type\tJOUR"

puts "end_tsv"

puts "status\tok"
