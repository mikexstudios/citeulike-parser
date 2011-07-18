#!/usr/bin/env perl

use LWP::Simple;
use HTML::TreeBuilder;
use Encode;


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

binmode STDOUT, ":utf8";

# Scrape the RIS file from the Nature.com site

$url = <>;

if ($url =~ m{/doifinder/(.*)}) {
	print "status\tredirect\thttp://dx.doi.org/$1\n";
	exit;
}

$page = get $url;
$page =~ s/\|\[(\w+)\]\|/&$1;/g;

my $tree = HTML::TreeBuilder->new();
$tree->parse($page);

my $head = ($tree->look_down('_tag','head'))[0];
my @meta = $head->look_down('_tag','meta');


if ($url =~ m{/naturejobs/}) {
	foreach $m (@meta) {
		my $name = $m->attr("name");
		my $content = $m->attr("content");
		#print "$name = $content\n";
		$name =~ /dc.identifier/i and do {
			$content =~ s/doi://;
			# sometimes see the DOI prefix twice!
			$content =~ s/(10\.\d\d\d\d)\/(10\.\d\d\d\d)/$1/;
			$doi = $content;
			print "status\tredirect\thttp://dx.doi.org/$doi\n";
			exit;
		};
	}
	print "status\terr\tCannot process $url\n";
	exit

}



print "begin_tsv\n";

my $doi = 0;

foreach $m (@meta) {
	my $name = $m->attr("name");
	my $content = $m->attr("content");
	#print "$name = $content\n";
	$name =~ /dc.identifier/i and do {
		$content =~ s/doi://;
		# sometimes see the DOI prefix twice!
		$content =~ s/(10\.\d\d\d\d)\/(10\.\d\d\d\d)/$1/;
		$doi = $content;
	};
	$name =~ /dc.date/i and do {
		$content =~ /(\d\d\d\d)(?:(?:-)(\d\d)(?:(?:-)(\d\d))?)?/;
		print "year\t$1\n" if $1;
		print "month\t$2\n" if $2;
		print "day\t$3\n" if $3;
	};
	# prism.issn = ERROR! NO ISSN
	$name =~ /prism.issn/i and do {
		print "issn\t$content\n" if $content =~ /\d+/;
	};
	$name =~ /dc.title/i and do {
		print "title\t$content\n" if $content;
	};
	$name =~ /prism.startingPage/i and do {
		print "start_page\t$content\n" if $content;
	};
	$name =~ /prism.endingPage/i and do {
		print "end_page\t$content\n" if $content;
	};
	$name =~ /prism.volume/i and do {
		print "volume\t$content\n" if $content;
	};
	$name =~ /prism.number/i and do {
		print "issue\t$content\n" if $content;
	};
	$name =~ /dc.publisher/i and do {
		print "publisher\t$content\n" if $content;
	};
	$name =~ /prism.publicationName/i and do {
		print "journal\t$content\n" if $content;
	};

# abstract                  | abstract          | AB
# address                   | address           | AD
# chapter                   | chapter           |
# date_other                |                   |
# edition                   | edition           |
# how_published             | howpublished      |
# institution               | institution       |
# isbn                      | isbn              | SN
# issn                      | issn              | SN
# issue                     | number            | IS
# journal                   | journal           | JO
# month                     |                   |
# organization              | organization      |
# school                    | school            |
# title_secondary           | booktitle         | BT
# title_series              | series            | T3
# type                      |                   |

}




my $abstract = $tree->look_down( '_tag', 'span',
	sub { $_[0]->attr("class") eq 'articletext' }
);
if ($abstract) {
	$abstract = $abstract->as_text;
}

if (!$abstract) {
	@abstract = $tree->look_down( '_tag', 'p',
		sub { $_[0]->attr("class") =~ m{\blead\b} }
	);
	if (@abstract) {
		$abstract = join (" ", map {$_->as_text} @abstract );
	}
}
if (!$abstract) {
	$abstract = $tree->look_down( '_tag', 'div',"id","abs");
	if ($abstract) {
		@abstract = $abstract->look_down( '_tag', 'p',
			sub { $_[0]->attr("class") =~ m{\babs\b} }
		);
		if (@abstract) {
			$abstract = join (" ", map {$_->as_text} @abstract );
		} else {
			undef $abstract;
		}
	}
}

if ($abstract) {
	print "abstract\t$abstract\n";
} else {
	print "abstract\t\n";
}

# We can get the bog-standard Nature linkout from just looking at the URL
# http://www.nature.com/naturejobs/2011/110714/full/nj7355-255a.html

if ($url =~ m{www.nature.com/cgi.*file=/([^/]+)/journal/v([^/]+)/n([^/]+)/([^/]+)/([^/]+)(_[^._]+)?.(html|pdf|ris)})	 {
# Old style
	($journal,$vol,$num,$view_type,$article)=($1,$2,$3,$4,$5);
} elsif ($url =~ m{www.nature.com/(n\w+)/journal/v([^/]+)/n([^/]+)/[^/]+/([^/_]+)\.(html|pdf|ris)}) {
# Fix to get Nature photonics/genetics to parse
	($journal,$vol,$num,$article)=($1,$2,$3,$4);
} elsif ($url =~ m{www.nature.com/([^/]+)/journal/v([^/]+)/n([^/]+s?)/[^/]+/([^/]+)(_[^._]+)?\.(html|pdf|ris)}) {
#http://www.nature.com/ni/journal/vaop/ncurrent/abs/ni.1771.html
	($journal,$vol,$num,$article)=($1,$2,$3,$4);
} else {
	print "status\terr\tThis page does not appear to be a Nature article\n";
	exit;
}

#if ($num !~ m{s}  && $num =~ /^\d+$/ && $vol =~ /^\d+$/) {
	print "linkout\tNATUR\t$vol\t$article\t$num\t$journal\n";
#}

# http://www.nature.com/ng/journal/v38/n6s/abs/ng1798.html

#print "http://www.nature.com/${journal}/journal/v${vol}/n${num}/ris/${article}.ris\n" ;

# Grab the RIS file

$ris = get "http://www.nature.com/${journal}/journal/v${vol}/n${num}/ris/${article}.ris" || (print "status\terr\tCouldn't fetch the citation details from the Nature web site.\n" and exit);


# Not sure why they give us this crap in the "date_other" field. Kill it.
print "date_other\t\n";

if ($doi) {
	print "linkout\tDOI\t\t$doi\t\t\n";
} elsif ($ris =~ m{UR  - http://dx.doi.org/(.*)}) {
	# We can extract a DOI if we're cunning, so that'll give us another linkout
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
