#!/usr/bin/env perl

use LWP::UserAgent;

#
# Copyright (c) 2005 Richard Cameron, CiteULike.org
# Copyright (c) 2005 Aidan Heerdegen
# All rights reserved.
#
# This code is derived from software contributed to CiteULike.org
# by
#    Will Wade <willwade@gmail.com>
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
#		 CiteULike <http://www.citeulike.org> and its
#		 contributors.
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

my $ua = LWP::UserAgent->new;
$ua->agent('CiteULike');

$url = <>;
chomp $url;

if ($url =~ m|scripts.iucr.org/cgi-bin/paper\?([0-9a-zA-Z]+)|)	 {
  # Process links from the IUCr
  $id=$1;
} elsif ($url =~ m|dx.doi.org/10.1107/([0-9a-zA-Z]+)|)	 {
  # Process DOIs
  $id=$1;
} else {
  print "status\terr\tThis page does not appear to be an IUCr article, try opening the link to this article in a separate window\n";
  exit;
}

print "begin_tsv\n";

print "linkout\tIUCR\t\t$id\t\t\n";

$bibtex_url = "http://scripts.iucr.org/cgi-bin/biblio?cnor=${id}&saveas=BIBTeX";
  
$res = $ua->get($bibtex_url) || (print "status\terr\tCouldn't fetch the BIBTeX details from the IUCr web site.\n" and exit);
$bibtex = $res->content;

# We can extract a DOI so that'll give us another linkout
if ($bibtex =~ m|doi = {10.1107/([A-Za-z0-9.-]+)|) {
	print "linkout\tDOI\t\t10.1107/$1\t\t\n";
}
print "end_tsv\n";

# Just print out the bibtex entry we snagged from IUCr
print "begin_bibtex\n";
print $bibtex;
print "end_bibtex\n";

if ($bibtex =~ m|url = |) {
  print "status\tok\n";
} else {
  print "status\terr\tCouldn't extract the details from IUCr website.\n";
}
