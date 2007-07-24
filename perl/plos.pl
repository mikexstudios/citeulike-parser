#!/usr/bin/env perl

use warnings;
use LWP::Simple;
use LWP::UserAgent;

#
# Copyright (c) 2005 Richard Cameron, CiteULike.org
# All rights reserved.
#
# This code is derived from software contributed to CiteULike.org
# by
#	 Stevan Springer <stevan.springer@gmail.com>
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

my $ua = LWP::UserAgent->new;

$url = <>;

#Examples of compatible url formats:
#ADD SOME HERE LATER

# Parser for PLOS Web Addresses:
#  Published articles, determine journal and doi. 
#formulate a link to the citation manager
#$url = "http://biology.plosjournals.org/perlserv/?request=get-document&doi=10.1371/journal.pbio.0040072";

if ($url =~ m{http://(\w+?).plosjournals.org/(.*?)doi=(\S+?)(&|$)}) {
	($journal_site,$doi) = ($1,$3);
	$url_citmgr = "http://$journal_site.plosjournals.org/perlserv/?request=cite-builder&doi=$doi";
#	print "Citation Manager:\t$url_citmgr\n";
} 
else {
	print "status\terr\t (1) This does not appear to be a PLoS article. Try posting the article from the fulltext page.\n" and exit;
}


# Get the url that links to the reference manager RIS file
$source_citmgr = get("$url_citmgr") || (print "status\terr\t (2) Could not retrieve information from the specified page. Try posting the article from the abstract page.\n" and exit);

if ($source_citmgr =~ m{"(.*)">Reference Manager Format<})
	{
	$link = $1;
	$link =~ s/&#38;/&/g;
	$link_refman = "http://$journal_site.plosjournals.org/perlserv/$link";
	}
else
	{
	print "status\terr\t (3) Could not find the citation details on this page. Try posting the article from the abstract page.\n" and exit;
	}


#Get the reference manager RIS file and check retrieved file
$refman = $ua->get("$link_refman") || (print "status\terr\t (4)Could not retrieve the citation for this article, Try posting the article from the abstract page.\n" and exit);
$ris = $refman->content;
unless ($ris =~ m{ER\s+-})
	{
	print "status\terr\tCouldn't extract the details from HighWire's 'export citation'\n" and exit;
	}
# Tweak DOI in RIS record slightly
$ris =~ s!UR  - http://dx.doi.org/10.1371%2F!UR  - http://dx.doi.org/10.1371/!;

#Generate linkouts and print output:
#PLoS linkout
print "begin_tsv\n";

#DOI linkout
print "linkout\tDOI\t\t$doi\t\t\n";

#PubMed/HubMed linkout
$source_abstract = get("$url") || (print "status\terr\t (2) Could not retrieve information from the specified page. Try posting the article from the abstract page.\n" and exit);
if ($source_abstract =~ m{=([0-9]+)&dopt=Citation" class="ncbi" title="View PubMed Record})
	{
	print "linkout\tPMID\t$1\t\t\t\n";
	}

print "end_tsv\n";
print "begin_ris\n";
print $ris;
print "end_ris\n";
print "status\tok\n";

