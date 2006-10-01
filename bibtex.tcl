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


# Responsible for parsing bibtex files
# We cheat and use BibTeX itself to do the parsing with a custom .bst file

proc bib_dir {} { 
	switch $::tcl_platform(platform) {
		unix {
			set tmpdir /tmp
		} macintosh {
			set tmpdir $::env(TRASH_FOLDER)  ;# a better place?
		} default {
			set tmpdir [pwd]
			catch {set tmpdir $::env(TMP)}
			catch {set tmpdir $::env(TEMP)}
		}
	}
	return "$tmpdir/bibulike"
}

proc bibtex_cleanup {} {
	set bibdir [bib_dir]
	foreach f [glob -directory $bibdir "*.*"] {
		file delete $f
	}
}

proc bibtex_style_dir {} {
	return $::env(PWD)
}

proc parse_bibtex {bibtex_rec} {
	set bibdir [bib_dir]
	file mkdir $bibdir
	
	# Vaguely unique filename
	set fname [expr {abs([clock clicks])}]
	
	set bibfile [open "$bibdir/$fname.bib" "w"]
	puts $bibfile $bibtex_rec
	close $bibfile

	set olddir [pwd]
	cd $bibdir
	
	file delete -- "$bibdir/$fname.aux"
	file delete -- "$bibdir/$fname.bbl"
	file delete -- "$bibdir/$fname.aux"
	file delete -- "$bibdir/$fname.blg"
	
	# Copy the style file into the directory
	file copy -force [bibtex_style_dir]/citeulike.bst $bibdir

	#Create a dummy .aux file which cites everything
	set fp [open "$bibdir/${fname}.aux" w]
	puts $fp [subst {\\citation{*}\n\\bibdata{$fname}\n\\bibstyle{citeulike}\n}]
	close $fp
	
	# Run BibTeX on it
	if {[catch {
		set bibtex [open "|bibtex $bibdir/$fname" r]
		set bibtex_stdout [read $bibtex]
		close $bibtex
	} msg]} {
		set ret(status) err
		if {[info exists bibtex_stdout]} {
			set ret(error) $bibtex_stdout
		} else {
			set ret(error) $msg
		}

		cd $olddir
		bibtex_cleanup
		return [array get ret]
	}

	# Extract what bibtex produced
	set fp [open "$bibdir/${fname}.bbl" r]
	set data [read $fp]
	close $fp

	set ret [bibtex_untangle $data]

	cd $olddir

	return $ret

}

# Extract a Tcl s-expression for the horribly tangled and encoded data
# which came back from the custom style file
proc bibtex_untangle {data} {

	set data [regsub -all {%\n} $data {}]
	set data [string map {"\n" " "} $data]
	set data [string map {"  " " " "~citeulike-magic-level-0-separator~" "\000"} $data]
	
	set level0 [split $data "\000"]
	
	foreach {type cite vals} $level0 {
		set type [string trim $type]
		set cite [string trim $cite]
		if {$type==""} {
			continue
		}
		set rec [list entry_type $type]

		set ret(cite) $cite
		foreach {k v} [split [string map {"~citeulike-magic-level-1-separator~" "\000"} $vals] "\000"] {
			set k [string trim $k]
			if {$k==""} {
				continue
			}

			# Try to remove stray BibTeX bracing which doesn't do much good
			set v [regsub {([^\\]|^)\{} $v {\1}]
			set v [regsub {([^\\])\}} $v {\1}]
			set v [string trim [string map {"  " " "} $v]]

			if {[::driver::is_multiple_field $k]} {
				lappend ret([bibtex_field_map $k]) $v
			} else {
				set ret([bibtex_field_map $k]) $v
			}
		}
		set ret(type) [bibtex_type_map $type]
	}


	# There some post-processing needs done
	if {[info exists ret(pages)]} {
		if {[regexp {^(.*?)--?(.*?)$} $ret(pages) -> ret(start_page) ret(end_page)]} {
			unset ret(pages)
		}
	}
								   
	bibtex_cleanup

	return [array get ret]
}

proc bibtex_field_map {field} {
	set field [string tolower $field]
	switch -- $field {
		booktitle {return title_secondary}
		howpublished {return how_published}
		number {return issue}
		series {return title_series}
	}
	return $field
}

proc bibtex_type_map {type} {
	switch -- [string tolower $type] {
		article {return JOUR}
		book {return BOOK}
		conference {return INCONF}
		inbook {return CHAP}
		incollection {return INCOL}
		inproceedings {return INCONF}
		manual {return MANUAL}
		mastersthesis {return MTHES}
		misc {return GEN}
		phdthesis {return THES}
		techreport {return REP}
		unpublished {return UNPB}
		proceedings {return CONF}
	}

	# Err. Arbitrary guess.
	return JOUR
}
