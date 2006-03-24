#!/usr/bin/env perl

use LWP::UserAgent;

my $ua = LWP::UserAgent->new;
$ua->agent('CiteULike');

my $url = <>;
chomp $url;

my $bibtex_url = $url . '/citation?include=cit&format=bibtex&action=submit';

my $res = $ua->get( $bibtex_url ) || (print "status\terr\tCouldn't fetch the bibtex file.\n" and exit);
my $bibtex = $res->content;

print "begin_tsv\n";

if ( $bibtex =~ m|PMID = {(\d+)}|i ){
    print "linkout\tPMID\t$1\t\t\t\n";
}
elsif ( $bibtex =~ m|^\@Article{(\d+),|i ){
	print "linkout\tPMID\t$1\t\t\t\n";
}
if ( $bibtex =~ m|DOI = {(.+?)}|i ){
    my $doi = $1;
    $doi =~ s!^http://dx.doi.org/!!;
	print "linkout\tDOI\t\t$doi\t\t\n";
}

print "end_tsv\n";

print "begin_bibtex\n";
print $bibtex;
print "end_bibtex\n";

if ($bibtex =~ m{\@Article}) {
	print "status\tok\n";
} else {
	print "status\terr\tError.\n";
}
