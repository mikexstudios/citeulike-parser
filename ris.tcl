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

# Responsible for parsing RIS information returned by the scraper
# part of the plugins

# This code is a disgrace, but it seems to work on most of the
# broken implementations of RIS which are enountered in the wild.

proc parse_ris {rec} {
	set last_tag ""

	foreach l [split $rec "\n"] {

		set l [string map [list "\n" "" "\r" ""] $l]

		# We never have any use for blank lines
		if {[regexp {^ *$} $l]} {
			continue
		}

		# This is the gospel spec for a field header
		set ok [regexp {^([A-Z][A-Z0-9])  - (.*)$} $l match k v]
		
		# Sometimes there are some borderline legal implementations
		# where empty fields are defined.
		if {!$ok && [regexp {^([A-Z][A-Z0-9])  -$} $l match k]} {
			set v ""
			set ok 1
		}
		

		# Maybe it's a line continuation
		# Technically should have some leading space, but this
		# doesn't always seem to happen, especially from one leading
		# publisher.
		if {!$ok && $last_tag!=""} {
			set k $last_tag
			set v $l
			set ok 1
		}


		if {$ok} {
			set v [string trim $v]
			set last_tag $k

			switch -regexp -- $k {

				{ER} {}
				{TY} {
					if {$v=="CHAP" || $v=="CHAPTER"} {
						set ret(type) INCOL
					} elseif {$v=="RPRT"} {
						set ret(type) REP
					} else {
						set ret(type) $v
					}
				}

				{ID} {
					set ret(id) $v
				}

				{(T1|TI|CT)} {
					append ret(title) "$v "
				}
				{BT} {
					if {$ret(ris_type) == "UNPB" || $ret(ris_type) == "BOOK"} {
						append ret(title) "$v "
					} else {
						set ret(title_secondary) $v
					}
				}

				{T2} {
					set ret(title_secondary) $v
				}

				{T3} {
					set ret(title_series) $v
				}


				{A1|AU|A2|ED|A3} {
					lappend ret(authors) $v
				}

				{Y1|PY|Y2} {
					set spl [split $v "/"]
					if {[llength $spl]>0} {
						foreach {year month day other} [split $v "/"] {}
						if {$year!="" && [string is integer $year]} {
							set ret(year) [format %04d $year]
						} else {
							set ret(year) ""
						}
						if {$month!="" && [string is integer $month]} {
							set ret(month) [format %d $month]
						} else {
							set ret(month) ""
						}
						
						if {$day!="" && [string is integer $day]} {
							set ret(day) [format %d $day]
						} else {
							set ret(day) ""
						}
						set ret(date_other) $other
					}
				}
				
				{N1|AB|N2} {
					append ret(abstract) "$v "
				}


				{JF|JO|JA} {
					set ret(journal) $v
				}
				{J1} {
					set ret(journal_user_abbrev_1) $v
				}
				{J2} {
					set ret(journal_user_abbrev_2) $v
				}

				{VL} {
					set ret(volume) $v
				}

				{IS} {
					set ret(issue) $v
				}

				{SP} {
					set ret(start_page) $v
				}

				{EP} {
					set ret(end_page) $v
				}

				{CP|CY} {
					set ret(city) $v
				}

				{PB} {
					set ret(publisher) $v
				}

				{SN} {
					set ret(serial) $v
				}

				{AD} {
					set ret(address) $v
				}


				{UR} {
					set ret(url) $v
					regexp {^http://dx.doi.org/(.*)$} $v -> ret(doi)
				}

				{L2} {
					set ret(fulltext_url) $v
				}

				{L1} {
					set ret(pdf_url) $v
				}

			}
		}
	}

	if {[info exists ret(abstract)]} {
		set ret(abstract) [string trim $ret(abstract)]
	}

	if {[info exists ret(title)]} {
		set ret(title) [string trim $ret(title)]
	}


	if {[info exists ret(authors)]} {
		set authors {}
		foreach author $ret(authors) {
			lappend authors [::author::parse_author $author]
		}
		set ret(authors) $authors
	}
	
		
	return [array get ret]
}
