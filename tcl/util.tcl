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

http::config

# These serve as a hack to let me develop from home
# using a SQUID proxy with access to the articles
if {[info exists env(http_proxy_host)] && $::env(http_proxy_host)!=""} {
	http::config -proxyhost $::env(http_proxy_host)
}

if {[info exists env(http_proxy_port)] && $::env(http_proxy_port)!=""} {
	http::config -proxyport $::env(http_proxy_port)
}

# This method contains a kid's version of a cookie jar.
# A "starter cookie jar", if you will. It will store cookies
# from previous responses and send them back again. The reason
# it's not a full implementation is that it completely ignores
# the hostname, and will send all cookies to all sites.
#
# This isn't a problem here, as we exec() a new process each
# time, and we're generally only sending requests to one
# publishers's site. One to keep an eye on though.
proc url_get {url {once_only 0}} {

	set url [string trim $url]
	set url [string map [list " " "%20"] $url]

	set getting 1
	set count 0
	set url_orig $url

	while {$getting==1} {

		# We'll pass in whatever cookies we know about
		set headers {}
		foreach {k v} [array get COOKIES] {
			lappend headers "Cookie" "$v;path=/"
		}

		# Do it.
		set token [http::geturl $url -headers $headers]
		upvar #0 $token state

		# Set whatever cookies get returned into our hi-tech
		# variable storage system.
		catch {unset location}
		foreach {name value} $state(meta) {
			if {[string tolower $name]=="set-cookie"} {
				set cookie_set [lindex [split $value {;}] 0]
				# Blatantly ignoring expires. host, path, etc
				if {[regexp {^([^=]+)=(.*)$} $cookie_set -> cookie_key cookie_val]} {
					set COOKIES($cookie_key) $cookie_set
				}
			}
			if {[string tolower $name] eq "location"} {
				set location $value
			}

		}

		set code [lindex $state(http) 1]
		if {$code==302 || $code==301} {

			if {![info exists location]} {
				error "No location in 30x HTTP headers while following $url"
			}

			set url $location

			if {$once_only} {
				return $url
			}
		} else {
			set getting 0
		}

		incr count
		if {$count>10} {
			error "Possible infinite loop fetching $url_orig"
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

proc put_tsv {key value} {
    puts "${key}\t${value}"
}

proc put_linkout {type ikey1 ckey1 ikey2 ckey2} {
    puts [join [list linkout $type $ikey1 $ckey1 $ikey2 $ckey2] "\t"]
}

proc map_long_month {month} {
    return  [string map [list \
	    January 1 \
	    February 2 \
	    March 3 \
	    April 4 \
	    May 5 \
	    June 6 \
	    July 7 \
	    August 8 \
	    September 9 \
	    October 10 \
	    November 11 \
	    December 12] $month]
}

proc parse_start_end_pages {p} {
    if {[regexp {^(\d+)-+(\d+)$} $p -> first last]} {
	if {$last < $first} {
	    # Something like 1293-5
	    set end_pos "end-[string length $last]"

	    set last "[string range $first 0 $end_pos]$last"
	}
	return [list $first $last]
    }
    return ""
}

proc strip_html_tags {str} {
    return [regsub -all {<[^>]+>} $str {}]
}
