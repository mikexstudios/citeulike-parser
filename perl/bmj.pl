#!/usr/bin/env perl

use LWP::UserAgent;

#
# Copyright (c) 2005 Richard Cameron, CiteULike.org
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

# Scrape the RIS file from the BMJ site

# This is a downright despicably awful (temporary) hack to avoid
# the BMJ blocking our GET requests with the message:
#
#   If you are using one of the popular "offline browsers" that allow you to download content from
#   a site and read it later, be aware that we impose one restriction on their use.
#
#   In order for us to provide reliable, continuous, and
#   timely access to this site for all
#   readers, we require that you configure your offline browser to request no more than one page per minute.
#
# We've asked them for a more permanent solution, but for now we'll argue that CiteULike
# is working in the "public good" and is not just spidering stuff for the hell of it.
# The bodge is to pretend that we're some microsoft browser. Please do not make
# a habit of this, as it's sneaky.
my $ua = LWP::UserAgent->new;
$ua->agent('Mozilla/4.0 (compatible; MSIE 5.0; Windows 95)');


$method = 'ris';
$url = <>;

print "begin_tsv\n";

if ($url =~ m{([^/]+).bmjjournals.com/cgi/content/([^/]+)/([0-9]+)/([0-9]+)/([0-9a-zA-Z-]+)})	 {
	($journal,$page_type,$vol,$num,$startpage)=($1,$2,$3,$4,$5);
	# NB: page_type isnt used. AFAIK this can either be full,abstract or abridged
} else {
	print "status\terr\tThis page does not appear to be a BMJ article\n";
	exit;
}
print "linkout\tBMJJ\t$vol\t${num},${startpage}\t\t$journal\n";

# lets grab the source of the shortest page - want to be quick.. 
$res = $ua->get("http://${journal}.bmjjournals.com/cgi/content/abstract/${vol}/${num}/${startpage}") || (print "status\terr\tCouldn't fetch the src details from the BMJ web site.\n" and exit);
$src = $res->content;

# Check to see if we're being throttled, and explain the situation to the user:
if ($src =~ m/Access to this site from IP address/) {
	print "status\terr\tThe BMJ site restricts access to clients (like CiteULike) requesting too many pages from it in a given period. It may be that you (or another CiteULike user) is requesting a lot of BMJ pages. Please wait for about half an hour and try to post the article again.\n";
	exit;
}

# We can extract a DOI if we're cunning, so that'll give us another linkout
if ($src =~ m{doi:10.1136/([A-Za-z0-9.-]+)}) {
	print "linkout\tDOI\t\t10.1136/$1\t\t\n";
}
# we can be really cool and get the pub/hubmed links too since bmj often have the access number in the page
# the access_num we want is numeric followed by a ampersand - not the ISI WOS one that is also in the source
#  e.g. /cgi/external_ref?access_num=15817527&
if ($src =~ m{access_num=([0-9]+)&link_type=PUBMED}) {
	print "linkout\tPMID\t$1\t\t\t\n";
}

print "end_tsv\n";

# TWO methods for BMJ - RIS or Bibtex
# Grab the RIS file

# because some highwire sites have odd citation links that arent the same as the journal name we have to scrape the proper key for their ris feeder
if ($src =~ m{gca=([A-Za-z0-9./;]+)"}) {
	$riskey = $1;
} else {
	$risjournal = $journal;
	$risjournal = "injuryprev" if $journal eq "ip";
	$risjournal = "archdischild" if $journal eq "adc";
	$riskey = "${risjournal};${vol}/${num}/${startpage}";
}
	
if ($method=='ris') {
		
	$res = $ua->get("http://${journal}.bmjjournals.com/cgi/citmgr?type=refman&gca=${riskey}") || (print "status\terr\tCouldn't fetch the ris details from the BMJ web site.\n" and exit);
	$ris = $res->content;
	print "begin_ris\n";
	print $ris;
	print "end_ris\n";
	if ($ris =~ m{ER  - }) {
		print "status\tok\n";
	} else {
		print "status\terr\tCouldn't extract the details from BMJ's 'export citation' link. $ris->content\n";
	}
} elsif ($method=='bibtex') {
# Could grab the BibTeX file too, but we don't want to create more load on the site than
# strictly required
	$res = get->("http://${journal}.bmjjournals.com/cgi/citmgr_bibtex?gca=${journal};${vol}/${num}/${startpage}") || (print "status\terr\tCouldn't fetch the bibtex details from the BMJ web site.\n" and exit);
	$ris = $res->content;
	print "begin_ris\n";
	print $ris;
	print "end_ris\n";
	if ($ris =~ m{URL = }) {
		print "status\tok\n";
	} else {
		print "status\terr\tCouldn't extract the details from BMJ's 'export citation' link.\n";
	}
}
