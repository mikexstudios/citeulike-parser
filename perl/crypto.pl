#!/usr/bin/env perl

use LWP::Simple;
use strict;

my $url = <>;

# Example URLs
# http://eprint.iacr.org/2006/125
# http://eprint.iacr.org/2006/125.ps
# http://eprint.iacr.org/2006/125.ps.gz
# http://eprint.iacr.org/2006/125.pdf
# http://eprint.iacr.org/cgi-bin/cite.pl?entry=2006/125

print "begin_tsv\n";

my $year; my $id;
unless((($year, $id) = $url =~ m#eprint.iacr.org/(\d{4})/(\d+)#) ||
       (($year, $id) = $url =~ m#eprint.iacr.org/cgi-bin/cite.pl\?entry=(\d{4})/(\d+)#)) {
  print "status\terr\tThis page does not appear to be a Cryptology ePrint Archive report\n";
  exit;
}

my $data = get "http://eprint.iacr.org/$year/$id" or
  (print "Couldn't fetch citation details from Cryptology ePrint Archive" and exit);

# Report id marked as character key because the leading zeros are significant
print "linkout\tIACR\t$year\t$id\t\t\n";

# Authors
if($data =~ m{<i>(.*?)</i>}is) {
  for my $author (split(/\s*?(?:,\s+and|,|\s+and)\s*/, $1)) {
    $author =~ s/\s+/ /g;
    $author =~ s/^\s+//g;
    $author =~ s/\s+$//g;
    print "author\t$author\n";
  }
}

# Title
if($data =~ m{<b>(.*?)</b>}is) {
  print "title\t$1\n";
}

# Abstract, <P> occurs in body of abstract, but not <p />
if($data =~ m{Abstract.*?</b>(.*?)\s*(?:<P>\s*)?<p />}is) {
  $_ = $1;
  s/\n/ \1/g;
  print "abstract\t$_\n";
}

# New date format
if($data =~ m{received (\d{1,2}) (\w{3}) (\d{4})}i) {
  print "day\t$1\n";
  print "month\t$2\n";
  print "year\t$3\n";
}

# Old date format
if($data =~ m{received (\w+) (\d+)\w+, (\d{4})}i) {
  print "day\t$2\n";
  print "month\t$1\n";
  print "year\t$3\n";
}

print "how_published\tCryptology ePrint Archive, Report $year/$id\n";
print "type\tELEC\n";
print "end_tsv\n";
print "status\tok";
