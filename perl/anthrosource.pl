#!/usr/bin/perl -w

#
# Copyright (c) 2005 Christopher Kelty
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

use warnings;
use LWP;
use HTTP::Cookies;

my $url = <> ;

if ($url =~ m{anthrosource.net/doi/(abs|pdf|pdfplus)/(.*)})
{ 
	$doi = $2;
}
else {die "This does not appear to be an anthrosource URL"};

# Or, assuming that people only cite from the abstract or pdf pages, then
# this is an easy hack, so long as the structure of the URLs
# remains the same.  6 of one, half dozen... 
#my @fields = split("/", $url);
#my $doi ="$fields[5]/$fields[6]";


# required attributes in order to produce Bibtex format
my $attributes ="&include=cit&format=bibtex&direct=1";

# concatenate for user agent request
my $content = "doi=".$doi.$attributes;

# The base url of the Anthrosource citation creation script
my $baseurl="http://www.anthrosource.net/action/downloadCitation"; 

# standard creation of user agent object
my $browser = new LWP::UserAgent;

# Anthrosource uses cookies, so the UserAgent needs to keep a cookie file 
# that must be initialized. 
$browser->cookie_jar(HTTP::Cookies->new(file => "lwpcookies.txt",
										autosave => 1));

# The request sends a POST request to Anthrosource
my $req = HTTP::Request->new(POST, $baseurl);
$req->content_type('application/x-www-form-urlencoded');
$req->content( $content );

# The response from Anthrosource ( this needs error handling code). 

my $resp = $browser->request($req);
my @ris = split("\n\n", $resp->as_string); #remove header crap

print "begin_tsv\n";
print "linkout\tDOI\t\t$doi\t\t\n";
print "end_tsv\n\n";
print "begin_bibtex\n";
print "$ris[1]";
print "end_bibtex\n";
print "status\tok\n";
