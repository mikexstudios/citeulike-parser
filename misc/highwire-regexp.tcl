set f [open "highwire-journal-list.txt" "r"]
set body [join [split [read $f] "\n"] "|"]
set body [regsub -all {\.} $body {\\.}]
puts "http://($body)/cgi(/|/content/)(abstract|short|extract|full|refs|reprint|screenpdf|summary)\[A-Za-z0-9.-/;\]+"
