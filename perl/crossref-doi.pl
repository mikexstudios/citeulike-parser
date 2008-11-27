#!/usr/bin/perl

# use module
use XML::Simple;
use Data::Dumper;
use warnings;
use LWP 5.64;

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

$doi = $1;

# pid=username:password (private!)
# (we already have a similar file .crossref-key so should use that)
my $pid="";
require "$ENV{HOME}/.crossrefid";

$url="http://www.crossref.org/openurl/?id=doi:$doi&noredirect=true&pid=$pid&format=unixref";

# print "URL=$url\n";

$response = $browser->get("$url") or (print "status\terr\t Could not retrieve information from the specified page. Try posting the article from the abstract page.\n" and exit);
$body = $response->content;

# print $body;

#
# Bizarrely, there's no XML decl ("<?xml..") so the encoding's assumed somewhere
# (not here).  Crossref can write a complicated XSD schema but not simple XML :-)
#
$xml = new XML::Simple;
# read XML file
#$data = $xml->XMLin("crossref-doi-sample.xml", ForceArray => [qw/title titles person_name identifier/]);
$data = $xml->XMLin($body, ForceArray => [qw/title titles person_name identifier issn/]);

$error = $data->{"doi_record"}->{"crossref"}->{"error"};
if ($error) {
	print "status\terr\t  Could not retrieve the information for that DOI. Crossref returned: $error\n";
	exit;
}

$base = $data->{"doi_record"}->{"crossref"}->{"journal"};

if (!$base) {
	print "status\terr\t  That DOI does not appear to be a journal.\n";
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


#########################
#nothing below here used - historic (as of 2008-11-26)
#
sub value {
	($ref) = @_;
	if (ref($ref) eq 'ARRAY') {
		return $ref->[0];
	}
	return $ref;
}

sub out {
	local ($key, $value) = @_;
	print "$key\t$value\n" if $value;
}

sub xxxx {
$article = $base->{"journal_article"};
$journal_metadata=$base->{"journal_metadata"};
$journal_issue=$base->{"journal_issue"};

# print Dumper($base);
print "begin_tsv\n";
out("journal",$journal_metadata->{"full_title"});
out("issn",$journal_metadata->{"issn"}->[0]->{"content"});
out("issn",$journal_metadata->{"issn"}->[1]->{"content"});

# Only take first of each of titles/title.
# TODO: maybe choose one with lang=en?
$titles=$article->{titles}->[0];
out("title", $titles->{title}->[0]);

out("volume", 		$journal_issue->{"journal_volume"}->{"volume"});
out("issue", 		$journal_issue->{"issue"});
out("day", 			$article->{"publication_date"}->{"day"});
out("month", 		$article->{"publication_date"}->{"month"});
out("year", 		$article->{"publication_date"}->{"year"});
out("start_page", 	$article->{"pages"}->{"first_page"});
out("end_page", 	$article->{"pages"}->{"last_page"});
out("doi",			$article->{"doi_data"}->{"doi"});
out("url",			$in_url);

$persons = $article->{"contributors"}->{"person_name"};
# sequence='first'|'additional', so sort on this key in reverse alphabetical order
# (I suspect they're always in the right order already)
for $p (sort { $b->{sequence} cmp $a->{sequence}} @$persons) {
	if ($p->{"contributor_role"} eq "author") {
		print "author\t".$p->{"surname"}.", ".$p->{"given_name"}."\n";
	}
}

# publisher 
# TODO check this - nothing in HOWTO.txt
$publisher = $article->{"publisher_item"}->{"identifier"}->[0];
if ($publisher) {
	out("pub_id", $publisher->{"content"});
	out("pub_id_type", $publisher->{"id_type"});
	print "linkout\tEVPII\t\t".$publisher->{"content"}."\t\t\n";	
}

$DOI = $article->{"doi_data"}->{"doi"};
print "linkout\tDOI\t\t$DOI\t\t\n" if $DOI;
print "type\tJOUR\n";

print "end_tsv\n";

}
