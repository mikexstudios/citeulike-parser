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

# Just pull the page down and see if it fits the bill.
set page [url_get $url]

# Try to get the stuff in the "Select format form" to aim for a BiBTeX file
if {![regexp {<form.*?Select alternative format</option>} $page form]} {
    bail "This doesn't appear to be an actual article on the MathSciNet site. You actually need to click on the article you're interested in to get the summary page before you can post it to CiteULike. Is it posible you tried to post some other page from MatSciNet, like a list of results as opposed to just one article."
}

puts "begin_tsv"

# If we've got a DOI, we'll have that now
if {[regexp {http://dx.doi.org/([^"]+)"} $page -> doi]} {
    puts [join [list linkout DOI {} $doi {} {}] "\t"]
}

# This appears to be the internal MathSCINet primary key
if {![regexp {<a href="http://www.ams.org/mathscinet-getitem.mr=(\d+)">Make Link</a>} $page -> msci_id]} {
    bail "No msci id"
}
puts [join [list linkout MSCI $msci_id {} {} {}] "\t"]

puts "end_tsv"


# BibTeX
# http://www.ams.org/mathscinet/search/publications.html?fmt=bibtex&pg1=MR&s1=2206712		
set bibtex_url "http://www.ams.org/mathscinet/search/publications.html?fmt=bibtex&pg1=MR&s1=${msci_id}"
set page [url_get $bibtex_url]
if {[regexp {<pre>(.*?)</pre>} $page -> bibtex]} {
    puts "begin_bibtex"
    puts $bibtex
    puts "end_bibtex"
} else {
    bail "Can't extract bibtex record"
}

puts "status\tok"
