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

# SYTLE ONE
if {[regexp {<!--_title-->} $page]} {
	# TITLE
	if {[regexp {<!--_title-->\n(.+)\n<!--_/title-->} $page -> title]} {
            if {[regexp {<!--_subtitle-->\n(.+)\n<!--_/subtitle-->} $page -> subtitle]} {
                set title [concat $title $subtitle]
            }
            regsub -all {<[^>]*>} $title "" title
            regsub -all "\n" $title " " title
            regsub -all {\s+} $title " " title
            regsub -all {&quot;} $title "\"" title
            puts "title\t$title"
	} else {
		bail "This article doesn't seem to have a title."
	}

	# AUTHOR
	if {[regexp {<!--_authorname-->(.+)<!--_/authorname-->} $page -> authors]} {
            regsub -all {<!--_affiliation-->.+?<!--_/affiliation-->} $authors "" authors
            regsub -all {<[^>]*>} $authors "" authors
            regsub -all {\s*and\s*} $authors "" authors
            regsub -all "\n" $authors " " authors
            regsub -all {\s+} $authors " " authors
            regsub -all {&amp;} $authors "," authors
            foreach author [split $authors ","] {
                set author [string trim $author]
                set author [string map {"  " " "} $author]
                puts "author\t$author"
            }
	} elseif {[regexp {<!--_byline-->\n(.+)\n<!--_/byline-->} $page -> author]} {
            regsub -all {<[^>]*>} $author "" author
            regsub -all "\n" $author " " author
            regsub -all {\s+} $author " " author
            set author [string trim $author]
            set author [string map {"  " " "} $author]
            puts "author\t$author"
	} else {
        	bail "Cannot parse author."
	}


	# JOURNAL NAME, VOLUME, ISSUE, YEAR, PAGE NUMBERS
	if {[regexp {<a name="top"></a>\n<i>([^>]+)</i>\s+(\d+)\.(\d+)\s+\((\d+)\)\s+(\d+)-(\d+)} $page -> journal volume issue year start_page end_page]} {
		puts "journal\t$journal\nvolume\t$volume\nissue\t$issue\nyear\t$year\nstart_page\t$start_page\nend_page\t$end_page"
	} elseif {[regexp {<a name="top"></a>\n<i>([^>]+)</i>\s+(\d+)\s+\((\d+)\)\s+(\d+)-(\d+)} $page -> journal issue year start_page end_page]} {
		puts "journal\t$journal\nissue\t$issue\nyear\t$year\nstart_page\t$start_page\nend_page\t$end_page"
	} else {
       		bail "I can't read the journal's metadata."
	}
	# ABSTRACT
	#if {[regexp {<abstract>\n([^\n]*)\n</abstract>} $page -> abstract]} {
	#	puts "abstract\t$abstract"
	#}
} elseif {[regexp {<div\s+id="article-title">} $page]} {
        # TITLE
        if {[regexp {<div\s+id="article-title">(.+?)</div>\s*<!--CLOSE article-title-->} $page -> title]} {
	        regsub -all {<[^>]*>} $title "" title
                regsub -all "\n" $title " " title
                regsub -all {\s+} $title " " title
                regsub -all {^\s+} $title "" title
                regsub -all {\s+$} $title "" title
                puts "title\t$title"
        } else {
            bail "This article doesn't seem to have a title."
        }

        # AUTHOR
        if {[regexp {<div\s+id="contrib">\n(.+?)\n</div>\s*<!--CLOSE contrib-->} $page -> author]} {
            regsub -all {<div\s+class="aff".+?<!--CLOSE aff-->} $author "" author
            regsub -all {<div.+} $author "" author
            regsub -all {<[^>]*>} $author "" author
            regsub -all "\n" $author " " author
            regsub -all {\s+} $author " " author
            set author [string trim $author]
            set author [string map {"  " " "} $author]
            puts "author\t$author"
        } else {
            bail "Cannot parse author."
        }

        # JOURNAL NAME, VOLUME, ISSUE, YEAR, PAGE NUMBERS
        if {[regexp {<i>([^>]+)</i>\s+(\d+)\.(\d+)\s+\((\d+)\)\s+(\d+)-(\d+)\n<hr />} $page -> journal volume issue year start_page end_page]} {
            puts "journal\t$journal\nvolume\t$volume\nissue\t$issue\nyear\t$year\nstart_page\t$start_page\nend_page\t$end_page"
        } else {
            bail "I can't read the journal's metadata."
        }
        # ABSTRACT
        #if {[regexp {<abstract>\n([^\n]*)\n</abstract>} $page -> abstract]} {
        #       puts "abstract\t$abstract"
        #}

} else {
	bail "Unsupported article markup."
}
puts "type\tJOUR"
puts "end_tsv"
puts "status\tok"
