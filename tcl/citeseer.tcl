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

# Not terribly reliable.
# TODO: Try another mirror if we get one of these errors.
if {[string first {<html xmlns="http://www.w3.org/1999/xhtml" lang="en-US"><head><title>System Busy</title>} $page]>-1} {
	bail "CiteSeer is reporting that the system is busy and asks that you try again later"
}

if {[string first {<h3>CiteSeer.IST is temporarily unavailable due to maintenance.<br>} $page]>-1} {
	bail "CiteSeer is reporting that the system is down for maintenance and asks that you try again later"
}

# CiteSeer pages should always have a BibTeX record in them
if {![regexp {<pre>(@.*?)</pre>} $page -> rec]} {
	bail "This CiteSeer page does not appear to have a BibTeX record in it."
}

# Dump out the bibtex record for the driver to worry about
puts "begin_bibtex"
puts $rec
puts "end_bibtex"


# Then the other bits and pieces
puts "begin_tsv"

# The linkout is easy. it's just the part of the URL.
if [regexp {^http://citeseer[^/]+(edu|unizh.ch|edu.sg)/([^/]+).html$} $url -> junk filename] {
	puts [join [list linkout CITES {} $filename {} {}] "\t"]
}

# Fill in the abstract which BibTeX might have missed
if {[regexp {<b>Abstract:</b>([^<]+)<a href=} $page -> abstract]} {
	puts "abstract\t[string trim $abstract]"
}
puts "end_tsv"

puts "status\tok"
