#!/usr/bin/env perl

#
# Copyright (c) 2008 Robert Blake
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
# 3. All advertising materials mentioning features or use of this software
#    must display the following acknowledgement:
#        This product includes software developed by
#        CiteULike <http://www.citeulike.org> and its
#        contributors.
# 4. Neither the name of CiteULike nor the names of its
#    contributors may be used to endorse or promote products derived
#    from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY CITEULIKE.ORG AND CONTRIBUTORS
# ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
# TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE FOUNDATION OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
#

use LWP::Simple;
use strict;

my $unclean_url = <>;

# Example URLs
# http://citeseerx.ist.psu.edu/viewdoc/summary?doi=10.1.1.19.4216
# http://citeseerx.ist.psu.edu.proxy2.library.uiuc.edu/viewdoc/summary?doi=10.1.1.19.4216

my $clean_url;
my $doi;
if ($unclean_url !~ m,^https?://citeseerx.ist.psu.edu(\.[^/]+)?/viewdoc/[^/]*doi=([0-9.]+),) { 
  print "status\tnot_interested\n";
  exit;
} else {
  $doi = $2;
  $clean_url = "http://citeseerx.ist.psu.edu/viewdoc/versions?doi=$doi";
}

my $data = "";
$data = get $clean_url;
if (not $data) {
  print "status\terr\tCouldn't connect to $clean_url\n";
  exit;
}

print "begin_tsv\n";
print "linkout\tCITESX\t\t$doi\t\t\n";

my $venue = "";
my $venue_type = "";
foreach my $line (split(/\n/, $data)) {
  if ($line !~ m,^\s*<tr><td>,) {
    next;
  }
  elsif($line =~ m,<tr><td>AUTHOR NAME</td><td>(.*)</td><td>,) {
    print "author\t$1\n"
  }
  elsif ($line =~ m,<tr><td>TITLE</td><td>(.*)</td><td>,) {
    print "title\t$1\n";
  }
  elsif ($line =~ m,<tr><td>ABSTRACT</td><td>(.*)</td><td>,) {
    print "abstract\t$1\n";
  }
  elsif ($line =~ m,<tr><td>YEAR</td><td>(.*)</td><td>,) {
    print "year\t$1\n";
  }
  elsif ($line =~ m,<tr><td>NUMBER</td><td>(.*)</td><td>,) {
    print "issue\t$1\n";
  }
  elsif ($line =~ m,<tr><td>PAGES</td><td>(.*)--(.*)</td><td>,) {
    print "start_page\t$1\n";
    print "end_page\t$2\n";
  }
  elsif ($line =~ m,<tr><td>VOLUME</td><td>(.*)</td><td>,) {
    print "volume\t$1\n";
  }
  elsif($line =~ m,<tr><td>VENUE TYPE</td><td>(.*)</td><td>,) {
    $venue_type = uc $1;
  }
  elsif($line =~ m,<tr><td>VENUE</td><td>(.*)</td><td>,) {
    $venue = $1;
  }
}

if ($venue and $venue_type) {
  if ($venue_type eq "CONFERENCE") {
    print "title_secondary\t$venue\n";
    print "type\tINCONF\n";
  }
  elsif ($venue_type eq "JOURNAL") {
    print "journal\t$venue\n";
    print "type\tJOUR\n";
  } 
  elsif ($venue_type eq "TECHREPORT") {
    print "journal\t$venue\n";
    print "type\tREP\n";
  }
} else {
    # Type is a required field, so we'll say ELEC if we don't know.
    print "type\tELEC\n";
}

print "end_tsv\n";
print "status\tok\n";
exit;
