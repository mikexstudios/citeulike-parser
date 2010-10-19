#!/usr/bin/env perl

use warnings;
#use LWP::Simple;
use LWP 5.64;
use File::Temp qw/tempfile/;
use WWW::Mechanize;
use Encode;

#
# Copyright (c) 2010 Fergus Gallagher, CiteULike.org
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


$url = <>;
chomp($url);


if ($url =~ m{http://www.springerprotocols.com/Abstract/doi/(.*)}) {
	my $doi = $1;
	my $s_url = "http://www.springerlink.com/openurl.asp?genre=article&id=doi:$doi";

	my $browser = LWP::UserAgent->new;
	$browser->cookie_jar({}); #springerlink.com expects we store cookies
	#let's emulate better some browser headers
	#'User-Agent' => 'Mozilla/4.76 [en] (Win98; U)',
	my @ns_headers = (
		'User-Agent' => '',
		'Accept' => 'image/gif, image/x-xbitmap, image/jpeg, image/pjpeg, image/png, */*',
		'Accept-Charset' => 'iso-8859-1,*,utf-8',
		'Accept-Language' => 'en-US',
	);

	my $resp = $browser->head("$s_url", @ns_headers);
	if ($resp) {
		my $code = $resp->code;
		if ($code == 200 ) {
			# this gives us back the last hop "request", i.e., the
			# URL of the last redirect
			my $req = $resp->request();
			my $uri = $req->uri;
			print "begin_tsv\n";
			print "linkout\tSPROT\t$doi\t\t\t\n";
			print "end_tsv\n";
			print "status\tredirect\t$uri\n";
			exit 0;
		}
	}
}

print "status\terr\tSorry, we cannot process that SpringerProtocols URL.\n" and exit;


