#!/usr/bin/env perl

use LWP::Simple;

#
# Copyright (c) 2005 Richard Cameron, CiteULike.org
# All rights reserved.
#
# This code is derived from software contributed to CiteULike.org
# by
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


# Scrape the RIS file from the Nature.com site

$url = <>;

print "begin_tsv\n";

# We can get the bog-standard Nature linkout from just looking at the URL

if ($url =~ m{www.nature.com/cgi.*file=/([^/]+)/journal/v([0-9]+)/n([0-9]+)/([^/]+)/([^/]+)(_[^._]+)?.(html|pdf|ris)})	 {
# Old style
	($journal,$vol,$num,$view_type,$article)=($1,$2,$3,$4,$5);
} elsif ($url =~ m{www.nature.com/([^/]+)/journal/v([0-9]+)/n([0-9]+)/[^/]+/([^/._]+)}) {
	($journal,$vol,$num,$article)=($1,$2,$3,$4);
} else {
	print "status\terr\tThis page does not appear to be a Nature article\n";
	exit;
}
print "linkout\tNATUR\t$vol\t$article\t$num\t$journal\n";

# Grab the RIS file

$ris = get "http://www.nature.com/${journal}/journal/v${vol}/n${num}/ris/${article}.ris" || (print "status\terr\tCouldn't fetch the citation details from the Nature web site.\n" and exit);

# We never get abstracts, and the seem to put the DOI in the N1 field,
# so override that.
print "abstract\t\n";

# Not sure why they give us this crap in the "date_other" field. Kill it.
print "date_other\t\n";

# We can extract a DOI if we're cunning, so that'll give us another linkout
if ($ris =~ m{UR  - http://dx.doi.org/(.*)}) {
	print "linkout\tDOI\t\t$1\t\t\n";
}

print "end_tsv\n";

print "begin_ris\n";
# Nature serve up a few lines of extra crap at the start of their record
# Strip all that off.
if ($ris =~ m{(TY  -.*ER  -)}s) {
	print $1."\n";
}
print "end_ris\n";

if ($ris =~ m{ER  - }) {
	print "status\tok\n";
} else {
	print "status\terr\tCouldn't extract the details from Nature's 'export citation' link.\n";
}
