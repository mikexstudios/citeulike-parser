#!/usr/bin/env tclsh

#
# Copyright (c) 2005 Chris Hall, Oversity Limited.
# All rights reserved.
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

# don't use the proxy (this is a bit grim)
set ::env(http_proxy_host) ""
set ::env(http_proxy_port) ""
source util.tcl

set url [gets stdin]

#
# Pull page...
#
set page [url_get $url]

#
# Look for an article id in the page's meta tags
#
if {![regexp {\<meta name="rft[_.]id" content="http\://journals.cambridge.org/action/displayAbstract\?aid=(\d+)"/\>} $page -> aid]} {
	bail "Cannot find an article_id in the page"
}

#
# Look for a DOI in the page
#
if {![regexp {\<meta name="rft_id" content="info:doi/([^"]+)"/\>} $page -> doi]} {
	set doi ""
}

puts "begin_tsv"

if {$doi ne ""} {
	puts "linkout\tDOI\t\t$doi\t\t"
}
puts "linkout\tCUP\t$aid\t\t\t"


set ris 0

#
# Make a citation export link - this is for RIS data
# BibTeX export may be a better option but keep this RIS code for now.
#
if {$ris == 1} {
	#
	# Abstract doesn't seem to be in the RIS file, so hack it out from the page direct, if it's there.
	#
	if {[regexp {<p class="AbsType">(.+?)</p>} $page -> abstract]} {
		puts abstract\t[string trim $abstract]
	}

	puts "end_tsv"
	set ris_url [subst {http://journals.cambridge.org/action/exportCitation?format=RIS&componentIds=${aid}&Download=Download}]
	set ris [url_get $ris_url]
	#
	# CUP seem to have decided to ignore the RIS specification, so their tokens now look like 'XX - content'
	# rather then 'XX  - content'
	#

	set fixed_ris [list]
	foreach ris_line [split $ris \n] {
		lappend fixed_ris [regsub {^([A-Z0-9]{2}) - } $ris_line {\1  - }]
	}

	puts "begin_ris"
	puts [join $fixed_ris \n]
	puts "end_ris"
} else {
	puts "end_tsv"
	set bib_url [subst {http://journals.cambridge.org/action/exportCitation?displayAbstract=Yes&format=BibTex&Download=Download&componentIds=${aid}}]
	set bib [url_get $bib_url]
	#
	# Dunno if it's common, but test-case #1 has several authors like "BISHOP,E.?J."
	# so let's strip out those "?"
	#
	# Also strip out any ABSTRACT SUMMARY text in abstract
	#
	set fixed_bib [list]
	foreach bib_line [split $bib \n] {
		if {[regexp {^author =} $bib_line]} {
			set bib_line [string map {? {}} $bib_line]
		}
		if {[regexp {^abstract =} $bib_line]} {
			regsub {\{\s*ABSTRACT\s*} $bib_line "\{" bib_line
			regsub {\{SUMMARY\s*} $bib_line "\{" bib_line
		}
		lappend fixed_bib $bib_line
	}

	puts "begin_bibtex"
	puts [join $fixed_bib \n]
	puts "end_bibtex"
}



puts "status\tok"
