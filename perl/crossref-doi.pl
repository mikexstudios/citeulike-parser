#!/usr/bin/perl -w

# use module
use XML::Simple;
use Data::Dumper;
use warnings;
use LWP 5.64;
use Encode;

#
# Copyright (c) 2008 Fergus Gallagher, CiteULike.org
# All rights reserved.
#
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


binmode STDOUT, ":utf8";

my $browser = LWP::UserAgent->new;
$browser->cookie_jar({}); #in case we need cookies
$browser->timeout(10); # secs

$in_url = <>;
chomp($in_url);

if (! $in_url =~ m{^http://dx\.doi\.org/}i ) {
	print "status\terr\tUnable to process that URL\n";
	exit;
}

$in_url =~ m{^http://dx\.doi\.org/(.*)}i;

# print "$in_url\n";

$doi = $1;

# pid=username:password (private!)
my $pid=`cat $ENV{HOME}/.crossref-key`;

$pid =~ s/\s+//g;

$url="http://www.crossref.org/openurl/?id=doi:$doi&noredirect=true&pid=$pid&format=unixref";

$response = $browser->get("$url") or (print "status\terr\t Could not retrieve information from the specified page. Try posting the article from the abstract page.\n" and exit);
$body = $response->content;
$body = decode("utf-8", $body); # why is this needed?

#
# Bizarrely, there's no XML decl ("<?xml..") so the encoding's assumed somewhere
# (not here).
#
$xml = new XML::Simple;

#
# Emergency bodge to fix completely toileted XML from crossref
#
#print "$body\n";
#$body =~ m{(<doi_record>.*</doi_record>)}s or do {
#	print "status\terr\t  Could not retrieve the information for that DOI. Invalid XML\n";
#	exit;
#};
#$body = $1;

# parse XML (not really necessary as crossref.tcl has to do this anyway)

$data = $xml->XMLin($body, ForceArray => [qw/title titles person_name identifier issn/]);

$base = $data->{"doi_record"}->{"crossref"};
if (!$base) {
	$base = $data->{"crossref"};
}


if (!$base) {
	print "status\terr\t  That DOI does not appear to be a known type.\n";
	exit;
}

$error = $data->{"doi_record"}->{"crossref"}->{"error"};
if ($error) {
	print "status\terr\t  Could not retrieve the information for that DOI. Crossref returned: $error\n";
	exit;
}

print "begin_tsv\n";
print "type\tJOUR\n";
print "url\t$in_url\n";
print "end_tsv\n";
print "begin_crossref\n";
print "$body\n";
print "end_crossref\n";
print "status\tok\n";
