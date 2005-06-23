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

# Common utility functions which come in handy when you're writing
# plugins for CiteULike in TCL

package require http

# These serve as a hack to let me develop from home
# using a SQUID proxy with access to the articles
if {[info exists env(http_proxy_host)] && $::env(http_proxy_host)!=""} {
	http::config -proxyhost $::env(http_proxy_host)
}

if {[info exists env(http_proxy_port)] && $::env(http_proxy_port)!=""} {
	http::config -proxyport $::env(http_proxy_port)
}

proc url_get {url} {

	set url [string trim $url]
	set url [string map [list " " "%20"] $url]

	set getting 1
	set count 0
	while {$getting==1} {

		set token [http::geturl $url]
		upvar #0 $token state
		
		set code [lindex $state(http) 1]
		if {$code==302 || $code==301} {
			array set meta $state(meta)
			set url $meta(Location)
		} else {
			set getting 0
		}

		incr count
		if {$count>10} {
			error "Possible infinite loop fetching $url"
		}
	}

	set page $state(body)
	
	return $page
}

proc bail {error} {
	puts "status\terr\t$error"
	exit 0
}

# Try to extract the start and end page from the raw text
proc parse_page_numbers {p} {
	
	if {[regexp {^(\d+)-+(\d+)$} $p -> first last]} {
		if {$last < $first} {
			# Something like 1293-5
			set end_pos "end-[string length $last]"
			
			set last "[string range $first 0 $end_pos]$last"
		}
		return [list $first $last]
	}
	return {}
}