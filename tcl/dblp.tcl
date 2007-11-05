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
set page [url_get $url]

# DBLP pages should always have a BibTeX record in them
if {![regexp {<pre>(@.*?)</pre>} $page -> rec]} {
	bail "This DBLP page does not appear to have a BibTeX record in it."
}

set rec [strip_html_tags $rec]

# Dump out the bibtex record for the driver to worry about
puts "begin_bibtex"

# Crossref information
if {[regexp {</pre>[^<]*<pre>(@.*?)</pre>} $page -> rec2]} {
        set rec2 [strip_html_tags $rec2]
        puts $rec2
}

puts $rec
puts "end_bibtex"

# Then the other bits and pieces
puts "begin_tsv"

if {[regexp {(10\...../[^\}]+)} $rec -> doi]} {
    puts "doi\t$doi"
}

# The linkout is part of the URL.
if [regexp {^http://dblp.uni-trier.de/rec/bibtex/(.+)$} $url -> filename] {
        puts [join [list linkout DBLP {} $filename {} {}] "\t"]
}

# DOI linkout.
if {[regexp {(10\...../[^\}]+)} $rec -> doi]} {
    puts [join [list linkout DOI {} $doi {} {}] "\t"]
}

puts "end_tsv"

puts "status\tok"
