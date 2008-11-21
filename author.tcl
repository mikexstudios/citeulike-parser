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


#
# Functions to parse plain text author names from references
#
# This a poor man's version of Perl's Lingua::EN:NameParse
# I use (some) of its regular expressions, but don't use its full
# power as I don't have a RecDescent parser.
# For now, this will probably do.


namespace eval author {
	# Try to define some of the tokens in the "grammar" as simple regexps.
	# These are influences from Lingua::EN::NameParse
	set TITLE_JUNK {(?:His (?:Excellency|Honou?r)\s+|Her (?:Excellency|Honou?r)\s+|The Right Honou?rable\s+|The Honou?rable\s+|Right Honou?rable\s+|The Rt\.? Hon\.?\s+|The Hon\.?\s+|Rt\.? Hon\.?\s+|Mr\.?\s+|Ms\.?\s+|M\/s\.?\s+|Mrs\.?\s+|Miss\.?\s+|Dr\.?\s+|Sir\s+|Dame\s+|Prof\.?\s+|Professor\s+|Doctor\s+|Mister\s+|Mme\.?\s+|Mast(?:\.|er)?\s+|Lord\s+|Lady\s+|Madam(?:e)?\s+|Priv\.-Doz\.\s+)+}
	set TRAILING_JUNK {,?\s+(?:Esq(?:\.|uire)?|Sn?r\.?|Jn?r\.?|[Ee]t [Aa]l\.?)} ; # The Indiana Jones school of naming your children..
	set NAME_2 {(?:[^ \t\n\r\f\v,.]{2,}|[^ \t\n\r\f\v,.;]{2,}\-[^ \t\n\r\f\v,.;]{2,})}
	set INITIALS_4  {(?:(?:[A-Z]\.\s){1,4})|(?:[A-Z]{1,4}\s)|(?:(?:[A-Z]\.-?){1,4}\s)|(?:(?:[A-Z]-){1,3}[A-Z]\s)|(?:(?:[A-Z]\s){1,4})|(?:(?:[A-Z] ){1,3}[A-Z]\.\s)|(?:[A-Z]-(?:[A-Z]\.){1,3}\s)}
	set PREFIX {Dell(?:[a|e])?\s|Dalle\s|D[a|e]ll\'\s|Dela\s|Del\s|[Dd]e (?:La |Los )?\s|[Dd]e\s|[Dd][a|i|u]\s|L[a|e|o]\s|[D|L|O]\'|St\.?\s|San\s|[Dd]en\s|[Vv]on\s(?:[Dd]er\s)?|(?:[Ll][ea] )?[Vv]an\s(?:[Dd]e(?:n|r)?\s)?}
	set SURNAME [subst {(?:$PREFIX)?(?:$NAME_2)}]
	set EMAIL {(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?)}
	

	# Try to pick out a few common formats with regexps first.
	proc common_formats {raw} {
		array set x [_common_formats $raw]
		

		# Post-process results of RE, unless verbatim flag is set

		if {![info exists x(verbatim)]} {

			if {[info exists x(initials)]} {
				set x(initials) [string toupper [string map {"." "" "-" "" " " ""} $x(initials)]]
			}

			if {[info exists x(first_name)]} {
				set x(first_name) [capitalize_name $x(first_name)]
			}

			if {[info exists x(last_name)]} {
				set x(last_name) [capitalize_name $x(last_name)]
			}

			if {[info exists x(first_name)]} {
				set initials [string range $x(first_name) 0 0]
				if {[info exists x(initials)]} {
					append initials $x(initials)
				}
				set x(initials) $initials
			}
		}

		set non_empty 0
		foreach k {last_name first_name initials} {
			if {[info exists x($k)]} {
				lappend ret [string trim $x($k)]
				set non_empty 1
			} else {
				lappend ret ""
			}
		}
		
		return $ret

	}

	proc _common_formats {raw} {
		variable TITLE_JUNK
		variable TRAILING_JUNK
		variable NAME_2
		variable INITIALS_4
		variable PREFIX
		variable SURNAME

		# "verbatim name"
		if {[regexp {^\s*"([^"]+)"\s*$} $raw -> ret(last_name)]} {
			set ret(verbatim) 1
			return [array get ret]
		}

		# Manually specified
		if {[regexp {^\s*=/([^/]*)/([^/]*)/([^/]*)/=\s*$} $raw -> ret(first_name) ret(initials) ret(last_name)]} {
			set ret(verbatim) 1
			return [array get ret]
		}

		# Cameron(,?) R.D.
		if {[regexp\
				 [subst {^($SURNAME),? ?($INITIALS_4)$}]\
				 $raw -> ret(last_name) ret(initials)]} { return [array get ret] }

		# Cameron, Richard D
		if {[regexp\
				 [subst {^($SURNAME), ?($NAME_2)( \[A-Z\]+)?}]\
				 $raw -> ret(last_name) ret(first_name) ret(initials)]} { return [array get ret]
		}

		# R.D. Cameron
		if {[regexp\
				 [subst {^($INITIALS_4)($SURNAME) $}]\
				 $raw -> ret(initials) ret(last_name)]} { return [array get ret]}
		
		# Richard D. Cameron
		# Richard Cameron
		if {[regexp\
				 [subst {^($NAME_2) ($INITIALS_4)?($SURNAME) $}]\
				 $raw -> ret(first_name) ret(initials) ret(last_name)]} { return [array get ret] }
		
		# R.D.Cameron
		if {[regexp\
				 [subst -nocommands {^((?:[A-Z]\\\.){1,3})($SURNAME) $}]\
				 $raw -> ret(initials) ret(last_name)]} {return [array get ret]}
		
				  
		# Cameron
		if {[regexp\
				 [subst {^($SURNAME) $}]\
				 $raw -> ret(last_name) ret(initials)]} { return [array get ret] }
		
		# D Waylon Smithers
		if {[regexp\
				 [subst {^($INITIALS_4)($NAME_2) ($SURNAME) $}]\
				 $raw -> ret(initials) ret(first_name) ret(last_name)]} { return [array get ret] }
		

		# Deborah Gladstein Ancona
		if {[regexp\
				 [subst {^($NAME_2) ($NAME_2) ($SURNAME) $}]\
				 $raw -> ret(first_name) middle_name ret(last_name)]} {
			set ret(initials) [string range $middle_name 0 0]
			return [array get ret] 
		}
   	
		# Smithers, D Waylon
		if {[regexp\
				 [subst {^($SURNAME), ($INITIALS_4)($NAME_2) $}]\
				 $raw -> ret(last_name) ret(initials) ret(first_name)]} { return [array get ret] }
		

		# Now we'll give up. This should always be the last case.
		# See if we can extract anything that looks even vaguely like a surname
		# and be happy with that.
		if {[regexp [subst {($SURNAME)}]\
				 $raw -> ret(last_name)]} { return [array get ret] }

	}


	proc parse_author {raw} {
		variable TITLE_JUNK
		variable TRAILING_JUNK
		variable EMAIL

		# trim whitespace
		set raw_trim [string trim $raw]

		# If we have a braced string, turn it into a quoted string
		if {([string index $raw_trim 0] eq "\{") && ([string index $raw_trim end] eq "\}")} {
			set raw \"[string range $raw_trim 1 end-1]\"
		}

		# Remove leading, trailing, double spacing,
		# and other unwanted bits and pieces.
		set work [string trim $raw]
		set work [regsub -all {\s{2,}} $work " "]
		set work [regsub -all {,{2,}} $work ","]
		set work [regsub -all {\s+\.+$} $work ""]
		set work [regsub -all {,+$} $work ""]
		set work [regsub -all {&nbsp;} $work " "]

		set work [regsub -all {[()]} $work ""]
		set work [regsub -all "$EMAIL" $work ""]
		
		# puts "$work"
		
		# Honorific and strange conventions just need to get binned immediately
		# (I don't support this for now, but because I keep the raw names
		#  this stuff can be added in retrospectively if required)
		set work [regsub "^$TITLE_JUNK" $work ""]
		set work [regsub "${TRAILING_JUNK}\$" $work ""]

		# The way we've phrased the REs, we need a trailing space
		append work " "
		
		set common [common_formats $work]

		if {[llength $common]>0} {
			lappend common $raw
			return $common
		}

		return {}
	}

	proc capitalize_name {name} {
		variable PREFIX

		foreach sub [split $name "-"] {

			#D'Angelo, and not D'angelo
			if {[regexp [subst {($PREFIX)(.*)$}] $sub -> prefix rest]} {
				set this $prefix
				append this [string totitle $rest]
			} else {
				set this [string totitle $sub]
			}
			lappend ret $this

		}
		set ret [join $ret "-"]

		return $ret
	}

	proc test_author {} {
		test_parse_author
	}
		
 	proc parse_test_cases {} {
		# last_name first_name initials raw
 		return [list \
					{"Person" "" "I" "Person I"}\
 					{"Edozien" "Leroy" "LC" "Edozien, Leroy C"}\
 					{"Chaitin" "" "GJ" "G. J. Chaitin"} \
 					{"Chaitin" "" "GJ" "G. J. Chaitin	 "}\
 					{"Chaitin" "" "GJ" "    G. J. Chaitin"}\
 					{"Chaitin" "" "GJ" "    G. J. Chaitin    "}\
					{"Chaitin" "" "GJ" "Prof. G. J. Chaitin"}\
 					{"Chaitin" "" "GJ" "Sir G. J. Chaitin"}\
 					{"Chaitin" "" "GJ" "Mister Prof. Dr. G. J. Chaitin"}\
 					{"Chaitin" "" "GJ" "Mister Prof. Dr. G. J. CHAITIN"}\
 					{"Chaitin" "" "GJ" "G. J. Chaitin Jnr."}\
 					{"Chaitin" "" "GJ" "G. J. Chaitin Sr"}\
 					{"Chaitin" "" "GJ" "G. J. Chaitin Sr."}\
 					{"Chaitin" "" "GJ" "G. J. Chaitin et al."}\
 					{"Ferreira" "Fernando" "F" "Fernando Ferreira"}\
 					{"Botz" "" "GW" "G.W.Botz"}\
 					{"D'Angelo" "Barbara" "BJ" "D'Angelo, Barbara J."}\
 					{"Moyo" "" "LM" "Moyo L.M."}\
 					{"Peyton-Jones" "Simon" "S" "Simon Peyton-Jones"}\
 					{"O'Donnell" "Jill" "J" "Jill O'Donnell"}\
 					{"Vonesch" "Jean-Luc" "J" "Jean-Luc Vonesch"}\
 					{"von Herrath" "Matthias" "M" "Matthias von Herrath"}\
 					{"O'Donnell-Tormey" "Jill" "J" "Jill O'Donnell-Tormey"}\
 					{"Smithers" "Waylon" "WD" "D Waylon Smithers"}\
 					{"Smithers" "Waylon" "WD" "Smithers, D Waylon"}\
 					{"von Herrath" "Matthias" "M" "Matthias von Herrath"}\
 					{"von Hoyningen-Huene" "Wolfgang" "W" "von Hoyningen-Huene, Wolfgang"}\
 					{"de Boer" "" "J" "de Boer, J."}\
 					{"van den Berg" "Debbie" "DLC" "Debbie L.C. van den Berg"}\
 					{"Botz" "" "GW" "Botz G. W.,"}\
 					{"" "" "" ""}\
 					{"Cameron" "" "" "Cameron"}\
					{"Chaitin" "Gregory" "GJ" "GREGORY J CHAITIN"}\
					{"A Company Name" "" "" "\"A Company Name\""}\
					{"A Company Name" "" "" "{A Company Name}"}\
 					{"Cameron" "" "" "rcameron@citeulike.org (Cameron et al)"}\
 					{"Cameron" "Richard" "RD" "Richard D Cameron"}\
 					{"Cameron" "Richard" "RD" "Richard  D  Cameron"}\
 					{"Steves" "" "BA" "Steves B.A."}\
 					{"Florek" "" "HJ" "Florek, H.-J."}\
 				   ]

		# To fix at some point:
	# 					{"Cho-Vega" "Jeong" "JH" "Jeong Hee Cho-Vega"}\
	#  					{"Yeung" "Henry" "HW" "Henry Wai-chung Yeung"}\

 	}
	
	proc test_parse_author {} {
		foreach case [parse_test_cases] {
			foreach {last_name first_name initials raw_name} $case {}
			
			# Raw name is element 3
			set result [parse_author [lindex $case 3]]

			if {[llength $result]!=[llength $case]} {
				error "Failed to parse $case"
			}

			foreach expected [lrange $case 0 2] actual [lrange $result 0 2] {
				if {$expected != $actual} {
					puts stderr "Failed parse: Expected $case but got $result"
				}
			}

		}
	}

	test_author
	
}
