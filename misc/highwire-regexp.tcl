set f [open "highwire-journal-list.txt" "r"]
set r_lines [split [read $f] "\n"]
set n_lines [list]
foreach line $r_lines {
	if {[string range $line 0 3] eq "www."} {
		set line [string range $line 4 end]
	}
	lappend n_lines $line
}
set body [join $n_lines "|"]
set body [regsub -all {\.} $body {\\.}]
puts "http://(www\\.)?(intl-)?($body)/"
