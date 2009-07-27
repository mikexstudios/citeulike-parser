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
source util.tcl

#
# Set this to force interpretation of the RIS record in UTF-8 (there's no appropriate header sent)
#
set http::defaultCharset utf-8

set url [gets stdin]

#
# Look for an content id in the url
#
set paper_id ""

regexp {paper_id=(\d+)} $url -> paper_id


if {$paper_id eq ""} {
	regexp {editlib\.org\/p\/(\d+)} $url -> paper_id
}

if {$paper_id eq ""} {
	bail "Cannot find a paper id in the URL"
}

#
# Pull page...
#
set page [url_get $url]

#
# Now, fetch the export URL
#

# http://go.editlib.org/index.cfm/files/citation_27830.bib?fuseaction=Reader.ExportAbstract&paper_id=27830&citationformat=BibTex

set    bibtex_url http://go.editlib.org/index.cfm/files/citation_${paper_id}.bib
append bibtex_url ?fuseaction=Reader.ExportAbstract&paper_id=$paper_id&citationformat=BibTex


set bibtex [url_get $bibtex_url]

#
# Key seems to come through with bad characters which foxes BibTeX -- strip 'em out
#
if {[regexp {^(\s*@[a-zA-Z_-]+\{)([^,]+)(.+)} $bibtex -> l1 key l2]} {
	set key [regsub -all {[^A-Za-z0-9:_-]} $key ""]
	if {$key eq ""} {
		set key none
	}
	set bibtex ${l1}${key}${l2}
}

puts "begin_tsv"

puts "linkout\tEdIT\t${paper_id}\t\t\t"

#
# ISSN appears to be in page, but not in citation export
#
if {[regexp {<span class="source_issn">ISSN (\d{4}-\d{4})</span>} $page -> issn]} {
	puts issn\t$issn
}

#
# Abstract doesn't apppear to be in the bibtex, but is in the page
#
if {[regexp {<p class="paper-abstract">(.*?)</p>} $page -> abstract]} {
	set abstract [string map {&gt; > &lt; < &amp; & &quot \" &nbsp; " "} $abstract]
	set abstract [regsub -all {\s+} $abstract " "]
	puts abstract\t$abstract
}

puts "end_tsv"

#
# Put out RIS metadata
#
puts "begin_bibtex"
puts $bibtex
puts "end_bibtex"


puts "status\tok"
