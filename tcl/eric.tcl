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

set url [gets stdin]

#
# Pull page... don't need it, but it validates that it exists
#
set page [url_get $url]

#
# Look for an "accno=<value>" in the url
#
if {![regexp {(?:\&|\?)accno=([A-Za-z0-9]+)(?:\&|$)} $url -> accno]} {
	bail "Cannot find accno in the URL"
}

#
# Now, fetch the export URL
#
set ris_url http://www.eric.ed.gov/ERICWebPortal/custom/portlets/clipboard/performExport.jsp?accno=${accno}&texttype=endnote

set ris [url_get $ris_url]

puts "begin_tsv"

puts "linkout\tERIC\t\t${accno}\t\t"

puts "end_tsv"

#
# Make a citation export link - this is for RIS data
#
puts "begin_ris"
puts $ris
puts "end_ris"

puts "status\tok"
