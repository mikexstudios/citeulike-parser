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
# CiteULike <http://www.citeulike.org> and its
# contributors.
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

sub oops {
    print "status\terr\t".shift()."\n";
    exit;
}

my $url = <> ;

if ($url =~ m{anthrosource.net/doi/(abs|pdf|pdfplus)/([^?\n]+)})
{ 
    $doi = $2;
}
else {oops "This does not appear to be an anthrosource URL"};

# Or, assuming that people only cite from the abstract or pdf pages, then
# this is an easy hack, so long as the structure of the URLs
# remains the same.  6 of one, half dozen... 
#my @fields = split("/", $url);
#my $doi ="$fields[5]/$fields[6]";


# required attributes in order to produce RIS format
# (only format=refman seems important)
my $attributes ="&format=refman";

# concatenate for user agent request
my $content = "doi=".$doi.$attributes;

# The base url of the Anthrosource citation creation script
my $baseurl="http://www.anthrosource.net/action/downloadCitation"; 

print "begin_tsv\n";
print "linkout\tDOI\t\t$doi\t\t\n";

# standard creation of user agent object
my $browser = new LWP::UserAgent;

# Anthrosource uses cookies, so the UserAgent needs to keep a cookie file 
# that must be initialized. 
$browser->cookie_jar( {} );

# Grab the abstract from the abstract page.
# This also has the nice effect of setting the cookies required
# for the subsequent request.
my $page = $browser->get("http://www.anthrosource.net/doi/abs/$doi") or oops "Couldn't fetch the abstract page from Anthrosource.net";

if ($page->content =~ m{<meta name="dc\.Description" content="(.+?)"></meta>}) {
	my $abstract = $1;
	$abstract =~ s/&quot;/\"/g;
	print "abstract\t$abstract\n";
}

# Get the RIS citation information
my $biblio = $browser->get("http://www.anthrosource.net/action/downloadCitation?$content")
    or oops "Couldn't fetch the citation informamtion from Anthrosource.net";
$ris = $biblio->content;

# Perform surgery to turn the author names into something a bit more parsable:
# Carmack,Robert M. -> Carmack, Robert M.
$ris =~ s/A1  - ([^,]+),(.*)/A1  - $1, $2/g;

print "end_tsv\n\n";
print "begin_ris\n";
print "$ris";
print "end_ris\n";
print "status\tok\n";
