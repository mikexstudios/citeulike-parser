#!/usr/bin/env perl

use LWP::UserAgent;
use strict;

my $ua = LWP::UserAgent->new;
$ua->agent('CiteULike');

my $url = <>;
chomp $url;
my ($fmkey) = $url=~m|/article/view/(\d+)|;
my $ris_url = $url;
$ris_url =~ s|article/view|rt/captureCite|;
$ris_url =~ s|$fmkey.*|$fmkey/0/proCite|;

if (!defined $fmkey) {
    print "status\terr\tCouldn't find First Monday article.\n";
    exit;
}

my $res = $ua->get( $ris_url ) || (print "status\terr\tCouldn't fetch the RIS\n" and exit);
my $ris = $res->content;

# months are returned as strings, but citeulike requires integers
my %months = (
    "January" => "1",
    "February" => "2",
    "March" => "3",
    "April" => "4",
    "May" => "5",
    "June" => "6",
    "July" => "7",
    "August" => "8",
    "September" => "9",
    "October" => "10",
    "November" => "11",
    "December" => "12",
);


print "begin_tsv\n";
print "linkout\tFSTMON\t$fmkey\t\t\t\n";
# The RIS JF entry contains more than just the journal name
foreach my $line (split(/\n/,$ris)) {
    if ($line =~ /^JF  - (.*); Volume (\d+).*Number (\d+) (-|— )\s*(\d+) (\w+) (\d{4})/) {
        print "journal\t$1\n";
        print "year\t$7\n";
        print "month\t".$months{"$6"}."\n";
        print "day\t$5\n";
        print "volume\t$2\n";
        print "issue\t$3\n";
    }
}
print "end_tsv\n";

print "begin_ris\n";
print "$ris\n";
print "end_ris\n";

print "status\tok\n";
