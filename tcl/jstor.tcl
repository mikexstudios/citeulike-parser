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
# CiteULike <http://www.citeulike.org> and its
# contributors.
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

source "util.tcl"

set url [gets stdin]

# Output the data in tab separated mode. Simple keyvalue pairs.
puts "begin_tsv"

proc jstor_id {url} {
    if {[regexp {jstor.org[^/]*/(browse|view|cgi-bin/jstor/viewitem)/([a-zA-Z0-9]+)/([a-zA-Z0-9]+)/([a-zA-Z0-9]+)} $url match junk m_journal m_issue m_article]} {
	set id [join [list $m_journal $m_issue $m_article] "/"]
	return $id
    }
    return ""
}


set id [jstor_id $url]

# We've come from something like this:
#   http://www.jstor.org/view/00318248/ap010204/01a00010
# but there's not point fetching that. We'll want the citation page which
# looks like this:
#   http://www.jstor.org/browse/00318248/ap010204/01a00010

# We've already extracted an ID like 
#   00318248/ap010204/01a00010

# We've possibly got one of the weird pemalinks if the id is null
if {$id==""} {
    if {[regexp {jstor.org/sici\?sici=([^&]+)} $url -> sici]} {
	set lpage [url_get "http://links.jstor.org/sici?sici=$sici"]
	if {[regexp {HREF="(/view/[^"]+)"} $lpage -> stdurl]} {
		set id [jstor_id "http://www.jstor.org$stdurl"]
	}
    }
}
	
set base "http://www.jstor.org/browse"
set url "${base}/${id}"
set page [url_get $url]


# Bloody mess. Hope they don't change the page format too much

# Stable URL gives us the linkout
if {[regexp "links.jstor.org/sici\\?sici=(\[^<\]+)</nobr>\n</DL>" $page -> stable_url]} {
    puts "linkout\tJSTOR\t\t${stable_url}\t\t"
} else {
    bail "This doesn't look like a JSTOR article. I'd expect to see a stable URL on the page."
}


#
# Title and authors
#
# Some review pages have a slightly different format, so there are three
# approaches here.

# For a review without an independent title
if {[ regexp {<FONT SIZE=\+1>Book Reviews</FONT>\n<DL COMPACT><DT><DD><B>----------------</B><DL COMPACT><DT><DD><B><A HREF="[^"]+">([^<]+)</a></B><DL COMPACT><DT><DD>([^\n]+)\n} $page -> obj_title obj_author]} {
    puts "title\t\[$obj_title ($obj_author)\]"
    regexp {<DL COMPACT><DT><DD>Review author\[s\]: ([^<]+)\n</DL>} $page -> authors
# For a review with an independent title
} elseif {[ regexp {<DL COMPACT><DT><DD>Review author\[s\]:} $page ]} {
    regexp {<DL COMPACT><DT><DD><B><A HREF="[^"]+">([^<]+)</a></B><DL COMPACT><DT><DD><B>([^<]+)</B><DL COMPACT><DT><DD>([^\n]+)\n} $page -> title obj_title obj_author
    puts "title\t$title \[$obj_title ($obj_author)\]"
    regexp {<DL COMPACT><DT><DD>Review author\[s\]: ([^<]+)\n</DL>} $page -> authors
# For an independent (non-revew) article
} else {
    regexp {<DL COMPACT><DT><DD><B><A HREF="[^"]+">([^<]+)</a></B><DL COMPACT><DT><DD>([^\n]+)\n</DL>} $page -> title authors
    puts "title\t$title"
}

# authors
foreach author [split $authors ";"] {
    set author [string trim $author]
    set author [string map {"  " " "} $author]
    puts "author\t$author"
}

# General citation details
if {[regexp {<DL COMPACT><DT><DD><I>([^<]+)</I>, Vol. (\d+), No. (\d+)(, [^.]+)?. \([^\)]+, (\d\d\d\d)\), pp. ([0-9-]+).\n</DL>} $page -> journal volume issue junk year pages]} {

    puts "journal\t$journal"
    puts "volume\t$volume"
    puts "issue\t$issue"
    puts "year\t$year"
    
    foreach {start_page end_page} [parse_page_numbers $pages] {}
    if {[info exists start_page] && $start_page!=""} {
	puts "start_page\t$start_page"
    }
    if {[info exists end_page] && $end_page!=""} {
	puts "end_page\t$end_page"
    }
}

# Abstract
if {[regexp {<H3>Abstract</H3><div class="abstract">([^<]+)</div>} $page -> abstract]} {
    puts "abstract\t$abstract"
}

#As far as I know, JSTOR only does journal articles
puts "type\tJOUR"


puts "end_tsv"

# So far so good.
puts "status\tok"
