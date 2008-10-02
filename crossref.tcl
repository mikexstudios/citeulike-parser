# Stub file to hold parser for Crossref's XML metadata

package require tdom

namespace eval CROSSREF {
}

proc CROSSREF::parse_xml {xml {hints {}}} {

	array set ret [list]

	set doc [[dom parse $xml] documentElement]

	set prefix /doi_records/doi_record/crossref/journal

	catch {
		set ret(journal) [[$doc selectNodes ${prefix}//full_title] text]
	}
	catch {
		set ret(issn) [[$doc selectNodes ${prefix}//issn] text]
	}

	catch {
		set ret(volume) [[$doc selectNodes ${prefix}/journal_issue/journal_volume/volume] text]
	}

	catch {
		set ret(issue) [[$doc selectNodes ${prefix}/journal_issue/issue] text]
	}

	catch {
		catch {
			set ret(day)   [[$doc selectNodes ${prefix}/journal_article/publication_date/day] text]
		}
		catch {
			set ret(month) [[$doc selectNodes ${prefix}/journal_article/publication_date/month] text]
		}
		catch {
			set ret(year)  [[$doc selectNodes ${prefix}/journal_article/publication_date/year] text]
		}
	}

	catch {
		set ret(title) [[$doc selectNodes ${prefix}/journal_article/titles/title\[1\]] text]
		set ret(title) [string trim $ret(title)]
	}

	#
	# Authors
	#    - NB we use the 'sequence' attribute to get author order correct
	#
	set a_nodes [$doc selectNodes ${prefix}/journal_article/contributors/person_name\[@contributor_role='author'\]]

	set author_list [list]

	foreach a_node $a_nodes {
		set seq [$a_node getAttribute sequence]
		if {$seq eq "first"} {
			set seq A
		} else {
			set seq Z
		}
		set fname ""
		set lname ""
		catch {
			set fname [[$a_node selectNodes given_name] text]
		}
		catch {
			set lname [[$a_node selectNodes surname] text]
		}

		lappend author_list [list $seq "$lname, $fname"]
	}

	foreach a [lsort -ascii -index 0 $author_list] {
		lappend ret(author) [lindex $a 1]
	}

	catch {
		set ret(start_page) [[$doc selectNodes ${prefix}/journal_article/pages/first_page] text]
	}
	catch {
		set ret(end_page) [[$doc selectNodes ${prefix}/journal_article/pages/last_page] text]
	}

	catch {
		set ret(doi) [[$doc selectNodes ${prefix}/journal_article/doi_data/doi] text]
	}

	#
	# Publisher IDs
	#
	catch {
		set id_node_list [$doc selectNodes ${prefix}/journal_article/publisher_item/identifier]
		if {[llength $id_node_list] == 1} {
			set id_node [lindex $id_node_list 0]
			set id      [$id_node text]
			set id_type [$id_node getAttribute id_type]

			set ret(pub_id)      $id
			set ret(pub_id_type) $id_type
		}
	}

	#
	# Linkouts
	#
	if {[info exists ret(doi)]} {
		lappend ret(linkout) [join [list DOI "" $ret(doi) "" ""] \t]
	}
	if {[info exists ret(pub_id)]} {
		switch -- $ret(pub_id_type) {
			pii {
				lappend ret(linkout) [join [list EVPII "" $ret(pub_id) "" ""] \t]
			}
		}
	}

	return [array get ret]
}
