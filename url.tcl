#
# Copyright (c) 2008 Richard Cameron, CiteULike.org
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


#
# Function to encode URL compenents
#
namespace eval cul::url {

	proc _init {} {
		for {set i 0} {$i < 256} {incr i} {
			set c [format %c $i]
			if {![string match {[-._~a-zA-Z0-9]} $c]} {
				set cmap($c) %[format %2X $i]
			}
			if {![string match {[-_.!~*'()A-Za-z0-9;,/?:@&=+$]} $c]} {
				set curimap($c) %[format %2X $i]
			}
			if {![string match {[-_.!~*'()A-Za-z0-9]} $c]} {
				set curicompmap($c) %[format %2X $i]
			}
		}
		set cmap(\n)       %0D%0A
		set curimap(\n)     %0D%0A
		set curicompmap(\n) %0D%0A

		variable charmap    [array get cmap]
		variable urimap     [array get curimap]
		variable uricompmap [array get curicompmap]
	}
	_init

	proc encode {urlcomponent} {
		variable charmap
		return [string map $charmap $urlcomponent]
	}

	proc decode {urlcomponent} {
		set urlcomponent [string map [list + { } "\\" "\\\\"] $urlcomponent]
		regsub -all -- {%([A-Fa-f0-9][A-Fa-f0-9])} $urlcomponent {\\u00\1} urlcomponent
		return [subst -novar -nocommand $urlcomponent]
	}

	proc encodeURI {uri} {
		variable urimap
		return [string map $urimap $uri]
	}

	proc encodeURIComponent {uricomp} {
		variable uricompmap
		return [string map $uricompmap $uricomp]
	}
}
