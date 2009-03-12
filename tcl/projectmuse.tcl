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

#
# Set this to force interpretation of the RIS record in UTF-8 (there's no appropriate header sent)
# I stole this from the psycontent.tcl file, shamelessly...
#
set http::defaultCharset utf-8

set url [gets stdin]


# Output the data in tab separated mode. Simple keyvalue pairs.
puts "begin_tsv"

#build the linkout
if {[regexp {muse.(?:jhu.edu|uq.edu.au).*(/journals/[^/]+/v[0-9]+/[0-9]+.+.(html|pdf))} $url -> l_url]} {
	puts "linkout\tMUSE\t\t$l_url\t\t"
} else {
	bail "This doesn't look like a valid link from Project Muse"
}

# Now, fetch the export URL
set sgml_url http://muse.jhu.edu/metadata/sgml${l_url}

set sgml [url_get $sgml_url]
if {[regexp {<doi>(.+)</doi>} $sgml -> doi]} {
	puts "doi\t$doi"
}

puts "end_tsv"

# Now, fetch the export URL
set ris_url http://muse.jhu.edu/metadata/ris${l_url}

set ris [url_get $ris_url]

# Strip out N1 field.  MUSE uses this for the issue designation, CUL wants to read it as abstract.
set ris [regsub {N1\s+-.+} $ris {}]


# Put out RIS metadata
puts "begin_ris"
puts $ris
puts "end_ris"

puts "status\tok"

