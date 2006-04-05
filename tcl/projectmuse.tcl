#!/usr/bin/env tclsh

#
# Copyright (c) 2005 Richard Cameron, CiteULike.org
# All rights reserved.
#
# This code is derived from software contributed to CiteULike.org
# by
#	Peter Graif <petergraif@yahoo.com>
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

# Compatible URL formats:
# http://muse.jhu.edu/journals/public_culture/v013/13.3breckenridge.html
# http://muse.jhu.edu/journals/sign_language_studies/v006/6.1rosenfeld.html

source "util.tcl"

set url [gets stdin]

# Output the data in tab separated mode. Simple keyvalue pairs.
puts "begin_tsv"

#build the linkout
if {[regexp {muse.jhu.edu[^/]*/journals/([^/]+)/v([0-9]+)/([0-9]+).([^.]+).html} $url -> l_journal l_volumelong l_volumeshort l_name]} {
	puts "linkout\tMUSE\t\t[join [list $l_volumelong $l_journal] :]\t\t[join [list $l_volumeshort $l_name] :]"
} else {
	bail "This doesn't look like a valid link from Project Muse"
}

#fetch the page
set page [url_get $url]

# TITLE
if {[regexp {<doctitle>([^<]+)</doctitle>} $page -> title]} {
	puts "title\t$title"
} else {
	bail "This article doesn't seem to have a title."
}

# AUTHOR
# nuke the date and affiliation tags
while {[regexp {([ |\n|\t]*)<date>([^<]+)</date>([ |\n|\t]*)} $page -> prejunk junk postjunk]} {
	regsub -all "$prejunk<date>$junk</date>$postjunk" $page "" page
}
while {[regexp {([ |\n|\t]*)<affiliation>([^<]+)</affiliation>([ |\n|\t]*)} $page -> prejunk junk postjunk]} {
	regsub -all "$prejunk<affiliation>$junk</affiliation>$postjunk" $page "" page
}
regsub -all "</surname><fname>" $page ", " page
while {[regexp {([ |\n|\t]*)</fname>([ |\n|\t]*)</docauthor>([ |\n|\t]*)<docauthor>([ |\n|\t]*)<surname} $page -> alphajunk betajunk gammajunk deltajunk]} {
	regsub -all "$alphajunk</fname>$betajunk</docauthor>$gammajunk<docauthor>$deltajunk<surname>" $page ";" page
}
if {[regexp {<docauthor>[ |\n|\t]*<surname>([^<]+)</fname>[ |\n|\t]*</docauthor>} $page -> authors ]} {
	foreach author [split $authors ";"] {
    	set author [string trim $author]
    	set author [string map {"  " " "} $author]
    	puts "author\t$author"
	}
}

# OTHER METADATA
if {[regexp {<journal>([^<]*)</journal>\n<journAbbrev>[^<]*</journAbbrev>\n<issn>([^<]*)</issn>\n<volume>([^<]*)</volume>\n<issue>([^<]*)</issue>\n<year>([^<]*)</year>\n<pubdate>([0-9]*)/([0-9]*)/[0-9]*</pubdate>\n<fpage>([^<]*)</fpage>\n<lpage>([^<]*)</lpage>} $page -> journal issn volume issue year month day start_page end_page]} {
	puts "journal\t$journal\nissn\t$issn\nvolume\t$volume\nissue\t$issue\nyear\t$year\nmonth\t$month\nday\t$day\nstart_page\t$start_page\nend_page\t$end_page"
} else {
	bail "I can't read the journal's metadata."
}

# ABSTRACT
if {[regexp {<abstract>\n([^\n]*)\n</abstract>} $page -> abstract]} {
	puts "abstract\t$abstract"
}

puts "type\tJOUR"
puts "end_tsv"
puts "status\tok"
