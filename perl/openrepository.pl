#!/usr/bin/env perl

use LWP::Simple;

#my $ua = LWP::UserAgent->new;
#$ua->agent('CiteULike');

my $url = <>;

print "begin_tsv\n";

if ($url =~ m{([A-Za-z0-9]+.openrepository.com/[^/]+)/handle/([0-9]+/[0-9]+)})	 {
# Standard Open Repository
	($repobase,$handle)=($1,$2);
} elsif ($url =~ m{(www.e-space.mmu.ac.uk/e-space)/handle/([0-9]+/[0-9]+)}) {
# Special case for MMU
	($repobase,$handle)=($1,$2);
} elsif ($url =~ m{(www.hirsla.lsh.is/lsh)/handle/([0-9]+/[0-9]+)}) {
# Special case for LSH
	($repobase,$handle)=($1,$2);
} elsif ($url =~ m{(arrts.gtcni.org.uk/gtcni)/handle/([0-9]+/[0-9]+)}) {
# Special case for GTCNI
	($repobase,$handle)=($1,$2);
} elsif ($url =~ m{(eric.exeter.ac.uk/exeter)/handle/([0-9]+/[0-9]+)}) {
# Special case for ERIC
	($repobase,$handle)=($1,$2);
} else {
	print "status\terr\tThis page does not appear to be an Open Repository entry\n";
	exit;
}

# Grab the RIS file
$ris = get "http://${repobase}/references?format=refman&handle=${handle}" || (print "status\terr\tCouldn't fetch the citation details from the web site.\n" and exit);

# Not sure why they give us this crap in the "date_other" field. Kill it.
print "date_other\t\n";

# We can extract a DOI if we're cunning, so that'll give us another linkout
if ($ris =~ m{^UR  - http://dx.doi.org/(.+)$}m) {
	print "linkout\tDOI\t\t$1\t\t\n";
} elsif ($ris =~ m{^M[1-3]  - (10([.]\d+)+/.+)$}m) {
	print "linkout\tDOI\t\t$1\t\t\n";
}

# Seems like hdl.handle.net/x/y is a generic redirector to each article - we can use it as a linkout
if ($ris =~ m{^UR  - http://hdl.handle.net/(\d+)/(\d+)}m) {
	print "linkout\tOPNREP\t$1\t\t$2\t\n";
}

# CiteULike's RIS parser puts N1,N2,AB in the abstract - should only use N2, but some sites are broken
# so the parser amalgamates all three. We need to remove N2,AB from this RIS file...
$ris =~ s/^(N1|AB)  - (.*)$\r?\n?//mg;

print "end_tsv\n";

print "begin_ris\n";
# Nature serve up a few lines of extra crap at the start of their record
# Strip all that off.
if ($ris =~ m{(TY  -.*ER  -)}s) {
	print $1."\n";
}
print "end_ris\n";

if ($ris =~ m{ER  - }) {
	print "status\tok\n";
} else {
	print "status\terr\tCouldn't extract the details from Open Repository's 'export citation' link.\n";
}
