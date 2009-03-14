#!/usr/bin/env perl

use warnings;
#use LWP::Simple;
use LWP 5.64;


#
# Copyright (c) 2005 Richard Cameron, CiteULike.org
# All rights reserved.
#
# 05/oct/2006 Marcus Granado <mrc.gran(@)gmail.com>
#   - added support for cookies,required by new springerlink.com portal
#
# This code is derived from software contributed to CiteULike.org
# by
#	 Stevan Springer <stevan.springer@gmail.com>
#
# with modifications by
# 	Fergus Gallagher <fergus.gallagher@citeulike.org>
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


my $browser = LWP::UserAgent->new;
$browser->cookie_jar({}); #springerlink.com expects we store cookies

$url = <>;
chomp($url);

#let's emulate better some browser headers
my @ns_headers = (
   'User-Agent' => 'Mozilla/4.76 [en] (Win98; U)',
   'Accept' => 'image/gif, image/x-xbitmap, image/jpeg, 
        image/pjpeg, image/png, */*',
   'Accept-Charset' => 'iso-8859-1,*,utf-8',
   'Accept-Language' => 'en-US',
  );

#Examples of compatible url formats:
#ADD some examples here later.


if ($url =~ m{http://www.springerprotocols.com/Abstract/doi/(.*)}) {
	my $doi = $1;
	my $s_url = "http://www.springerlink.com/openurl.asp?genre=article&id=doi:$doi";
	my $resp = $browser->head("$s_url", @ns_headers);
	if ($resp) {
		my $code = $resp->code;
		if ($code == 200 ) {
		# this gives us back the last hop "request", i.e., the
		# URL of the last redirect
			my $req = $resp->request();
			my $uri = $req->uri;
			print "status\tredirect\t$uri\n";
			exit 0;
		}
	}	
}




# Parser for Springerlink Web Addresses:
# ADD a parser to link from other forms of the article to the abstract later.

# lets remove any initial 'www.' : springerlink.com doesn't like it

$url =~ s/www\.//;

# Remove any instance of metapress in the URL
$url =~ s/springerlink\.metapress\.com/springerlink.com/;

# Remove any trailing proxy stuff on the end
$url =~ s!springerlink\.com[^/]+/!springerlink.com/!;


# extract the UID from the end of the line.
$url =~ m{/content/([^/?]+)};

my $slink = $1 || "";


# TODO copy changes for url_abstract into other metapress plugin "roysoc"
# Assuming it works

# If we have a UID from the source URL, then we can jump direct to the RIS
if ($slink) {
	$url_abstract = "http://springerlink.com/content/$slink";
	# this annoying, need to get a page first - probably a cookie thing.  
	# At least the HTTP HEAD works and so speeds things up.
	$browser->head("$url_abstract");
	$link_ris = "http://springerlink.com/export.mpx?code=$slink&mode=ris";
} else {
	# Get the link to the reference manager RIS file
	$url_abstract = $url;
	$response = $browser->get("$url_abstract") or (print "status\terr\t (2) Could not retrieve information from the specified page. Try posting the article from the abstract page.\n" and exit);

	$source_abstract = $response->content;
	if ($source_abstract =~ m{href='(.*)'\s*>RIS<}){
		$link_ris = "http://springerlink.com/$1";
		$link_ris =~ s/&amp;/&/; # replace &amp; for &
		$link_ris =~ s/\.\.\/*//; # remove any ../ 
		$link_ris =~ s/\.\.\/*//; # remove any ../ again
	}
	else{ 
		print "status\terr\t (3) Could not find a link to the citation details on this page. Try posting the article from the abstract page\n" and exit;
	}
}


#Get the reference manager RIS file and check retrieved file
$response = $browser->get("$link_ris",@ns_headers) || (print "status\terr\t (2) Could not retrieve information from the specified page. Try posting the article from the abstract page.\n" and exit);

$ris = $response->content;

unless ($ris =~ m{ER\s+-}) {
	print "status\terr\tCouldn't extract the details from SpringerLink's 'export citation'\n" and exit;
}

#Generate linkouts and print RIS:
print "begin_tsv\n";

# Springer seem to use DOIs exclusively
#DOI linkout
#if ($ris =~ m{doi:([0-9a-zA-Z_/.:-]*)}) {
#if ($ris =~ m{doi:(\S*)}) {

my $have_linkouts = 0;
if ($ris =~ m{UR  - http://dx.doi.org/([0-9a-zA-Z_/.:-]+/[0-9a-zA-Z_/.:-]+)}) {
	print "linkout\tDOI\t\t$1\t\t\n";
	$have_linkouts = 1;
} 
if ($ris =~ m{UR  - http://www.springerlink.com/content/([^/\n]+)}) {
	print "linkout\tSLINK\t\t$1\t\t\n";
	$have_linkouts = 1;
} elsif ($slink) {
	print "linkout\tSLINK\t\t$slink\t\t\n";
	$have_linkouts = 1;
} 

if (!$have_linkouts) {
	print "status\terr\tThis document does not have a DOI or a Springer ID, so cannot make a permanent link to it.\n" and exit;
}

print "end_tsv\n";
print "begin_ris\n";
print "$ris\n";
print "end_ris\n";
print "status\tok\n";


