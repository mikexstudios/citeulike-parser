#!/usr/bin/env perl

use LWP::UserAgent;
use strict;

my $ua = LWP::UserAgent->new;
$ua->agent('CiteULike');

my $url = <>;
chomp $url;
my ($ckey) = $url=~m|/([^/]+)\.html$|;
my $bibtex_url = $url;
$bibtex_url =~ s/langev\/paper/langev\/bibtex/;
$bibtex_url =~ s/html$/btx/;

my $res = $ua->get( $bibtex_url ) || (print "status\terr\tCouldn't fetch the bibtex file.\n" and exit);
my $bibtex = $res->content;

print "begin_tsv\n";
print "linkout\tLNGV\t\t$ckey\t\t\n";
undef $/;
if ( $bibtex =~ m|\n\s*doi\s*=\s*{(.+?)}|i ){
    my $doi = $1;
    print "linkout\tDOI\t\t$doi\t\t\n";
}

print "end_tsv\n";

print "begin_bibtex\n";
print $bibtex;
print "end_bibtex\n";

print "status\tok\n";
