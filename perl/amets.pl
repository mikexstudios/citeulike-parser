#!/usr/bin/env perl

#
# !!!!!!DEFUNCT!!!!!!
# AMETS now uses atypon via amets.py.
# Keeping this just for reference.
#


use LWP::Simple;
use LWP::UserAgent;
use URI::Escape;
use HTTP::Cookies;

#
# Copyright (c) 2005 Dan Hodson, d.l.r.hodson@reading.ac.uk
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
#


# Extract Abstract data for American Meteorological Society Journals.

$url = <>;
$ourl = $url;

#convert abstract URL to citation request URL
#$url =~ s/get-abstract|get-document/download-citation/;
#$url="$url&site=amsonline&t=procite";
$url =~ s/doi\/abs\//action\/downloadCitation\/\?doi\=/;
$url =~ s/doi\/full\//action\/downloadCitation\/\?doi\=/;
# standard creation of user agent object
my $browser = new LWP::UserAgent;

# AMS uses cookies
$browser->cookie_jar( {} );


#retrieve the RIS data
$flag=1;
while($flag==1){
    # Get the RIS file
    my $page = $browser->get("$url")|| die(print "status\terr\tCouldn't fetch the citation details from the AMetS web site.\n");
    $ris=$page->content;

# remove N1 and N2 fields - do not contain abstract, although CUL expects them to
    $ris =~ s/N1  -.+?$//m;
    $ris =~ s/N2  -.+?$//m;
    # not quite sure about this, but hey ho!
    $ris =~ s/UR  -.+?$/UR  - $ourl/m;

#    print $ris;
	$flag=0;
	#if document has moved - keep following the links to the final RIS file.
	if ($ris =~ m/document has moved \<a href=\"(.+?)\"/){
		$url=$1;
		$url =~ s/\&amp\;/\&/g;
		$flag=1;
	}
}
# extract doi from N1 parameter,

# unescape it, and stuff it back into RIS record

if ($ris =~ m{DO  - (.*?)$}m) {
#	$DOI = uri_unescape($1);
	$DOI = $1;
	$DOI =~ s/\s//g;
}else{
	print "status\terr\tCouldn't extract the details from AMetS's 'export citation' link.\n";
	exit;
}


#TSV output
print "begin_tsv\n";
print "linkout\tDOI\t\t$DOI\t\t\n";
# print "date_other\t\n";
print "end_tsv\n";
#RIS output
print "begin_ris\n";
# INVALID!!! TY MUST COME FIRST
#print "UR  - http://journals.ametsoc.org/";
print $ris;
print "\nend_ris\n";
if ($ris =~ m{ER  -}) {
	print "status\tok\n";
} else {
	print "status\terr\tCouldn't extract the details from AMetS's 'export citation' link.\n";
}
exit;
