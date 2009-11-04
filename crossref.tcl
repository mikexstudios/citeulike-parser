# Stub file to hold parser for Crossref's XML metadata

package require tdom
package require http

namespace eval CROSSREF {
}


proc CROSSREF::_get_text {node} {
	return [string trim [$node asText]]
}

#<JOURNALS>#####################################################################
proc CROSSREF::parse_journal {doc} {
	array set ret [list]

	set ret(type) JOUR

	set prefix //doi_record/crossref/journal

	catch {
		set ret(journal) [_get_text [$doc selectNodes ${prefix}//full_title]]
	}

	# there can be multiple issn e.g., media_type="print"|"electronic"
	# Which one?  Just choose first one for now.
	catch {
		set ret(issn) [[$doc selectNodes ${prefix}//issn\[1\]] text]
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
		set ret(title) [_get_text [$doc selectNodes ${prefix}/journal_article/titles/title\[1\]]]
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
			set fname [string trim [[$a_node selectNodes given_name] text]]
		}
		catch {
			set lname [string trim [[$a_node selectNodes surname] text]]
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
#<CHAPTERS>#####################################################################
proc CROSSREF::parse_chapter {doc} {
	array set ret [list]

	set ret(type) CHAP

	set prefix //doi_record/crossref/book
	set meta "$prefix/book_metadata"
	set content "$prefix/content_item\[1\]"

	catch {
		set ret(title_secondary) [_get_text [$doc selectNodes ${prefix}/book_metadata/titles/title\[1\]]]
	}
	catch {
		set ret(title_series) [_get_text [$doc selectNodes ${prefix}/book_metadata/series_metadata/titles/title\[1\]]]
	}

	# there can be multiple issn e.g., media_type="print"|"electronic"
	# Which one?  Just choose first one for now.
	catch {
		set ret(issn) [[$doc selectNodes ${meta}/issn\[1\]] text]
	}

	catch {
		set ret(volume) [[$doc selectNodes ${meta}/volume] text]
	}

	catch {
		catch {
			set ret(day)   [[$doc selectNodes ${meta}/publication_date/day] text]
		}
		catch {
			set ret(month) [[$doc selectNodes ${meta}/publication_date/month] text]
		}
		catch {
			set ret(year)  [[$doc selectNodes ${meta}/publication_date/year] text]
		}
	}

	catch {
		set ret(title) [_get_text [$doc selectNodes ${content}/titles/title\[1\]]]
	}

	#
	# Authors
	#    - NB we use the 'sequence' attribute to get author order correct
	#
	set a_nodes [$doc selectNodes ${content}/contributors/person_name\[@contributor_role='author'\]]

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
		set ret(start_page) [[$doc selectNodes ${content}/pages/first_page] text]
	}
	catch {
		set ret(end_page) [[$doc selectNodes ${content}/pages/last_page] text]
	}

	catch {
		set ret(doi) [[$doc selectNodes ${content}/doi_data/doi] text]
		lappend ret(linkout) [join [list DOI "" $ret(doi) "" ""] \t]
	}
	catch {
		set evpii [[$doc selectNodes ${content}/doi_data/resource] text]
		if {$evpii ne "" && [regexp {http://linkinghub.elsevier.com/retrieve/pii/(.*)} $evpii -> id]} {
			set ret(pub_id)      $id
			set ret(pub_id_type) pii
			lappend ret(linkout) [join [list EVPII "" $id "" ""] \t]
		}
	}

	return [array get ret]
}

proc ns_test {xml} {
	set doc [[dom parse $xml] documentElement]
	puts "XXX1: $xml"
		# <doi_record xmlns="http://www.crossref.org/xschema/1.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
		# <crossref><journal>
	puts "XXX2: [[$doc firstChild] nodeName]"; # crossref
	puts "XXX3: [[[$doc firstChild] firstChild] nodeName]"; #journal
	puts "XXX3.1: [[[$doc firstChild] firstChild] namespaceURI]"; #http://www.crossref.org/xschema/1.0

	puts "XXX4.1a: [$doc selectNodes crossref]"; # NOTHING
	puts "XXX4.1b: [$doc selectNodes -namespaces {default http://www.crossref.org/xschema/1.0} default:crossref]"; # domNode
	puts "XXX4.1c: [[$doc selectNodes -namespaces {default http://www.crossref.org/xschema/1.0} default:crossref] nodeName]"; # crossref

	puts "XXX4.2a: [$doc selectNodes //journal]"; # NOTHING
	puts "XXX4.2b: [$doc selectNodes -namespaces {default http://www.crossref.org/xschema/1.0}  //default:crossref/default:journal]"; # domNode
	puts "XXX4.2c: [$doc selectNodes  //crossref/journal]"; # NOTHING
}

proc CROSSREF::parse_xml {xml {hints {}}} {


	regsub -all {xmlns(:\w+)?="[^"]+"} $xml {} xml

	set doc [[dom parse $xml] documentElement]

	set ret ""


	# Journal?
	catch {
		if {[$doc selectNodes //doi_record/crossref/journal] ne ""} {
			set ret [parse_journal $doc]
		}
	}
	if {$ret ne ""} {
		return $ret
	}

	# Chapter?
	catch {
		if {[$doc selectNodes //doi_record/crossref/book/content_item\[@component_type="chapter"\] ] ne ""} {
			set ret [parse_chapter $doc]
		}
	}
	if {$ret ne ""} {
		return $ret
	}

	return {}

}


proc CROSSREF::load {doi} {
	# LAZY LAZY LAZY
	set key [string trim [exec head -1 $::env(HOME)/.crossref-key]]

	set qs [::http::formatQuery id doi:$doi noredirect true pid $key format unixref]

	set url "http://www.crossref.org/openurl/?$qs"

	puts "CROSSREF::load  $url"

	set token [http::geturl $url -timeout 5000]
	upvar #0 $token state
	set code [lindex $state(http) 1]

	if {$code != 200} {
		set message [lrange $state(http) 2 end]
		puts "ERROR: cannot access crossref @ $url :: code=$code $message"
		return ""
	}

	return $state(body)
}
