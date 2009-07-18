#!/usr/bin/env perl

use LWP::UserAgent;

my $ua = LWP::UserAgent->new;
$ua->agent('CiteULike');

my $url = <>;
chomp $url;
$url =~ s!/(abstract|comments|email|citation|postcomment).*$!!;

#my $bibtex_url = $url . '/citation?include=cit&format=bibtex&action=submit';
my $bibtex_url = $url . '/citation';
print "url = $bibtex_url\n";

my $res = $ua->post( $bibtex_url , [include => "cit", format => "bibtex" , action => "submit"]) || (print "status\terr\tCouldn't fetch the bibtex file.\n" and exit);
my $bibtex = $res->content;

# sometime wrapped in <pre>...</pre>

$bibtex =~ s|</?pre>||g;

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
	print "status\terr\It has not been possible to find the article information from this page. If you're sure you're posting a valid article then, if this problem persists, you may like to consider raising a bug report.\n";
}

