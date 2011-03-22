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

binmode STDOUT, ":utf8";

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


# strip query part
$url =~ s/\?.*$//;

$url =~ m{^http://www\.cell\.com/(?:([^/]+)(?:/))?abstract/(.*)$};

my ($journal, $pii) = ($1 || "", $2 || "" );

if (!$pii) {
	print "status\terr\tUnable to recognise this URL as a valid CELL abstract\n";
	exit;
}

# sometime the () are url-encoded
$pii = urldecode($pii);

# print "$journal :: $pii\n";

my $pii_enc = urlencode($pii);

my $url_ris = "http://www.cell.com/citationexport?format=cite-abs&citation-type=RIS&pii=$pii_enc&action=download&Submit=Export";

my $response = $browser->get("$url_ris",@ns_headers) || (print "status\terr\tCould not retrieve information from the specified page. Try posting the article from the abstract page.\n" and exit);

my $ris = $response->content;

print "begin_tsv\n";
print "linkout\tCELL\t\t$journal\t\t$pii\n";
print "end_tsv\n";
print "begin_ris\n";
print "$ris\n";
print "end_ris\n";
print "status\tok\n";

exit 0;

#<urlencode>####################################################################
sub urlencode {
	use URI::Escape qw( uri_escape_utf8 );
	return uri_escape_utf8( $_[0] );
}
sub urldecode {
	use URI::Escape qw( uri_unescape );
	return uri_unescape( $_[0] );
}

