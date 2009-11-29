#!/usr/bin/env tclsh

#
# Copyright (c) 2005 Richard Cameron, CiteULike.org
# All rights reserved.
#
# This code is derived from software contributed to CiteULike.org
# by
#    Michael Miller <citeulike@michmill.com>
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

source "util.tcl"

set url [gets stdin]

#
# If the URL is of the form http://link.aip.org/link..., then it's a redirect to a proper URL
#
if {[regexp {^http://link.aip.org/link} $url]} {
	set url [url_get $url 1]
}


# Could come in a couple of ways--lets figure out which ones are ok to parse and which ones we should bail on:
#This is the format that we'll probably get our URLs in; notably it has an ID, which is subject to change, but can get us the BibTex reference
#http://scitation.aip.org/getabs/servlet/GetabsServlet?prog=normal&id=PRVDAQ000071000012123523000001&idtype=cvips&gifs=Yes
# If it's in any other form, we should be able to pull this same ID--for example, this BibTex ref or something similar
# http://scitation.aip.org/getabs/servlet/GetCitation?fn=view_bibtex2&source=scitation&PrefType=ARTICLE&PrefAction=Add+Selected&SelectCheck=PSISDG004583000001000139000001&downloadcitation=+Go+
# Could also come, from the scitation search site, as:
# In this case, we have to parse the page to get that ID where we can go and get the URL
# http://scitation.aip.org/vsearch/servlet/VerityServlet?KEY=ALL&smode=strresults&maxdisp=10&possible1=networks&possible1zone=article&OUTLOG=NO&viewabs=PSISDG&key=DISPLAY&docID=1&page=0&chapter=0


#TODO: Add error-checking for each of the many hits to web pages

proc aip_id {url} {

	if {[regexp "aip.org/getabs/" $url]} {
		if {[regexp "id=(\[a-zA-Z0-9\]+)&" $url -> m_id]} {
			set id ${m_id}
			return $id
			puts "${url}"
		}
	}
	# Watch out for this one--won't let you do it if you aren't in the network--need to test on a university network
	if {[regexp "aip.org/vsearch/" $url]} {
		#we need to parse the page
		#So, there's a box with the ID we want
		set temppage [url_get $url]

		#Currently, it bails here, uglily, if it gets a nonexistent page--could use some fixing
		if {[regexp "id=(\[a-zA-Z0-9\]+)&" $temppage -> m_id]} {
			set id $m_id
			puts "${id}"
			return $id
		}
	}
	return ""
}

proc striphtml {my_string} {
	while {[regexp {<.*?>} $my_string]} {
		regsub {<.*?>} "${my_string}" "" my_string
	}
	set my_string [string trim $my_string]
	return $my_string
}


set id [aip_id $url]
if {[string equal "" $id]} {
	bail "This does not seem to be a URL I recognize; it does not contain an ID."
}

# We've come from something like this:
#   http://scitation.aip.org/getabs/servlet/GetabsServlet?prog=normal&id=PRVDAQ000071000012123523000001&idtype=cvips&gifs=Yes
# but there's not point fetching that. We'll want the citation page which
# looks like this:
#   http://scitation.aip.org/getabs/servlet/GetCitation?source=scitation&PrefType=ARTICLE&PrefAction=Add+Selected&SelectCheck=PRVDAQ000071000012123523000001&fn=view_bibtex2&downloadcitation=+Go+

# We've already extracted an ID like
#   PRVDAQ000071000012123523000001

set base "http://scitation.aip.org/getabs/servlet/GetCitation?source=scitation&PrefType=ARTICLE&PrefAction=Add+Selected&SelectCheck="
set end "&fn=view_bibtex2&downloadcitation=+Go+"
set url "${base}${id}${end}"
set page [url_get $url]

# OK, this should give us the BibTex file
if {[regexp {<html} $page]} {
	bail {"I couldn't find the BibTex link on the page"}
}


# Modify the bibtex record to fix their malformed page field
# pages = {021903} should be
# pages = {021903+}

set page [regsub {\npages = {([0-9]+)}} $page { pages = {\1+}}]

#
# Key seems to come through with crly brace and backslash escapes whch foxes bibtex -- strip 'em out
#
if {[regexp {^(\s*@[a-zA-Z_-]+\{)([^,]+)(.+)} $page -> l1 key l2]} {
	set key [regsub -all {[^A-Za-z0-9:_-]} $key ""]
	if {$key eq ""} {
		set key none
	}
	set page ${l1}${key}${l2}
}

puts "begin_bibtex"
puts $page
puts "end_bibtex"

# Other stuff--which we could live without if we had to



# The linkout should be at the end of the page, and we can just use it--I need to figure out this linkout business
puts "begin_tsv"
puts "linkout\tAIP\t\t${id}\t\t"
if {[regexp {url = \{http://link\.(aps|aip)\.org/(.*)\}} $page -> domain toparse]} {
	if {[string equal $domain "aps"]} {
		if {[regexp {abstract/([A-Z]+)/v([0-9]+)/([ep]{1,2}[0-9]+)(?:.*?)} $toparse -> ckey_1 ikey_1 ckey_2]} {
			puts "linkout\tAPS\t${ikey_1}\t${ckey_1}\t\t${ckey_2}"
		}
	} elseif {[string equal $domain "aip"]} {
		if {[regexp {link/\?([A-Z]+)/([0-9]+)/([a-zA-Z0-9]+)(?:.*?)} $toparse -> ckey_1 ikey_1 ckey_2]} {
			puts "linkout\tAIPP\t${ikey_1}\t${ckey_1}\t\t${ckey_2}"
		}
	}

}

#Abstract is a lot more iffy--might not always come out clean, but that's OK

#First, go back to the page where we can pick it up

set base "http://scitation.aip.org/getabs/servlet/GetabsServlet?prog=normal&id="
set end "&idtype=cvips&gifs=Yes"
set url "${base}${id}${end}"



if {[catch {
	set abpage [url_get $url]
}]} {
	set abpage ""
}

#set abpage [url_get $url]
#puts $abpage
#puts [regexp "abstract" $abpage]
#These pages are really ugly and inconsistent--save me!
#} elseif {[regexp {\(Received[^)]*; accepted[^)]*\)\s*<p>(.*?)</p>} $abpage -> abstract]} {
#} elseif {[regexp {(1996\)\s*?<p>.*?</p>)} $abpage -> abstract]} {

if {[regexp -nocase {<META name="description" content=\"([^\"]+)\">} $abpage -> abstract]} {
	set abstract [striphtml $abstract]
	puts "abstract\t${abstract}"
} elseif {[regexp {<div class=\"abstract\">.*?<p>(.*?)</p>.*?</div>} $abpage -> abstract]} {
	set abstract [striphtml $abstract]
	puts "abstract\t${abstract}"
} elseif {[regexp {<div id=\"abstract\">.*?<p>(.*?)</p>.*?<p>&copy;.*? <i>The American Physical Society</i></p>.*?</div>} $abpage -> abstract]} {
	set abstract [striphtml $abstract]
	puts "abstract\t${abstract}"
} elseif {[regexp {<div id=\"abstract\">(.*?)<br/><br/>&copy;.*?personal use only.</i>.*?</div>} $abpage -> abstract]} {
	set abstract [striphtml $abstract]
	puts "abstract\t${abstract}"
} elseif {[regexp {<p class=\"abstract\">(.*?)</p>} $abpage -> abstract]} {
	set abstract [striphtml $abstract]
	puts "abstract\t${abstract}"
} elseif {[regexp {\(Received[^)]*?\)\s*?<p>(.*?)</p>} $abpage -> abstract]} {
	regsub {&copy;.*} $abstract "" abstract
	regsub {[^.]*copyrighted by.*\.} $abstract "" abstract
	set abstract [striphtml $abstract]
	puts "abstract\t${abstract}"
} elseif {[regexp {<h3>.*?</h3>\s*?<dl>.*?</dl>\s*?<p>\s*?<p>[^<>]*?<p>\s*?(.*?)&copy;[0-9][0-9][0-9][0-9]} $abpage -> abstract]} {
	set abstract [striphtml $abstract]
	puts "abstract\t${abstract}"
}

#} elseif {[regexp {<!-- Component: abstract -->(?:.*?)<p>(.*?)&copy;} $abpage -> abstract]} {
#	set abstract [striphtml $abstract]
#	puts "abstract\t${abstract}"
#}

# Next, get DOI from the same page
# This DOI routine is pretty iffy and needs to be checked pretty badly

if {[regexp "doi:</a>(\[a-zA-Z0-9\./\]+)" $abpage -> my_doi]} {
	puts "linkout\tDOI\t\t${my_doi}\t\t"
	puts "doi\t${my_doi}"
} elseif {[regexp "/doi/(\[a-zA-Z0-9\./\]+)" $abpage -> my_doi]} {
	puts "linkout\tDOI\t\t${my_doi}\t\t"
	puts "doi\t${my_doi}"
}


puts "end_tsv"

# So far so good.
puts "status\tok"
