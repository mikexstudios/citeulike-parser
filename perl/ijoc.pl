#!/usr/bin/env perl

use LWP::UserAgent;
use strict;

my $ua = LWP::UserAgent->new;
$ua->agent('CiteULike');

my $url = <>;
chomp $url;
my ($ijoc_key) = $url=~m|/article/view/(\d+)|;
my $ris_url = $url;
$ris_url =~ s|article/view|rt/captureCite|;
$ris_url =~ s|$ijoc_key.*|$ijoc_key/0/proCite|;

if (!defined $ijoc_key) {
    print "status\terr\tCouldn't find IJOC article.\n";
    exit;
}

my $res = $ua->get( $ris_url ) || (print "status\terr\tCouldn't fetch the RIS\n" and exit);
my $ris = $res->content;

print "begin_tsv\n";
print "linkout\tIJOC\t$ijoc_key\t\t\t\n";
# The RIS JF entry contains more than just the journal name
foreach my $line (split(/\n/,$ris)) {
    if ($line =~ /^JF  - (.*); Vol (\d+)\s+\((\d{4})\)/) {
        print "journal\t$1\n";
        print "year\t$3\n";
        print "volume\t$2\n";
    }
}
print "end_tsv\n";

print "begin_ris\n";
print "$ris\n";
print "end_ris\n";

print "status\tok\n";
