#!/usr/bin/env perl

use warnings;
use LWP::Simple;

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



$url = <>;

#Examples of compatible url formats:
#ADD some examples here later.


# Parser for Springerlink Web Addresses:
#ADD a parser to link from other forms of the article to the abstract later.
	

$url_abstract = $url;

# Get the link to the reference manager RIS file
$source_abstract = get("$url_abstract") || (print "status\terr\t (2) Could not retrieve information from the specified page. Try posting the article from the abstract page.\n" and exit);

if ($source_abstract =~ m{href="(.*)"\s>RIS<}){
	$link_ris = "http://springerlink.com$1";
}
else{
	print "status\terr\t (3) Could not find a link to the citation details on this page. Try posting the article from the abstract page.\n" and exit;
}


#Get the reference manager RIS file and check retrieved file
$ris = get("$link_ris") || (print "status\terr\t (2) Could not retrieve information from the specified page. Try posting the article from the abstract page.\n" and exit);
unless ($ris =~ m{ER\s+-})
	{
	print "status\terr\tCouldn't extract the details from SpringerLink's 'export citation'\n" and exit;
	}

#Generate linkouts and print RIS:
print "begin_tsv\n";

#Print Abstract if lucky
#if ($source_abstract =~ m{>Summary(.*)</div>}) {
#	print "abstract\t$1";
#}

# Springer seem to use DOIs exclusively
#DOI linkout
#if ($ris =~ m{doi:([0-9a-zA-Z_/.:-]*)}) {
if ($ris =~ m{doi:(\S*)}) {
	print "linkout\tDOI\t\t$1\t\t\n";
} else {
	print "status\terr\tThis document does not have a DOI, so cannot make a permanent link to it.\n" and exit;
}
	
#PubMed/HubMed linkout
#if ($source_abstract =~ m{access_num=([0-9]+)&link_type=PUBMED})
#	{
#	print "linkout\tPMID\t$1\t\t\t\n";
#	}

print "end_tsv\n";
print "begin_ris\n";
print "$ris\n";
print "end_ris\n";
print "status\tok\n";




