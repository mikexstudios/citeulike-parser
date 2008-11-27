#!/usr/bin/env perl

use LWP 5.64;
use strict;
use warnings;

my $url = <>;
chomp($url);

# Only the first 2 fields "OK <URL>" are actually used, the others
# just for debugging

#
# This should never happen as it should be already checked in 
# the calling proc go_posturl_doi_rewrite (post.tcl)
#
if (! $url =~ m{^http://dx\.doi\.org/|doi:}i ) {
	print "OK\t$url\tNOT_CHANGED\tNO_MATCH\tEOL1\n";
	exit 0;
}

if ($url =~ m{^doi:\s*(.*)}i) {
	$url = "http://dx.doi.org/$1";
}

my $browser = LWP::UserAgent->new;
$browser->cookie_jar({}); # need this for, e.g., Springer

my @ns_headers = (
   'User-Agent' => 'Mozilla/4.76 [en] (Win98; U)',
   'Accept' => 'image/gif, image/x-xbitmap, image/jpeg, 
        image/pjpeg, image/png, */*',
   'Accept-Charset' => 'iso-8859-1,*,utf-8',
   'Accept-Language' => 'en-US',
  );


# Hmm, this doesn't seem to work as expected, e.g.,
# http://dx.doi.org/10.1234/xay (just a "random" url) hangs "forever"
# (I wonder if 10.1234 is a spam trap? - Most other dud url redirect to
# a sensible page, albeit with the same URL)
$browser->timeout(10); # secs

my $resp = $browser->head("$url", @ns_headers) or do {
	print "OK\t$url\tNOT_CHANGED\tERROR\tEOL2\n";
	exit 0;
};

# As mentioned above, most dud DOIs give a error page (200 OK)
# but, luckily for us, with the same URL. So a dud URL will appear
# here with uri=url, even though the line says "CHANGED".  
# No worries, though potential problem if doi.org changes things
# e.g., might get a redirect to completely wrong page.
#
my $code = $resp->code;
if ($code == 200 ) {
	# this gives us back the last hop "request", i.e., the
	# URL of the last redirect
	my $req = $resp->request();
	my $uri = $req->uri;

	print "OK\t$uri\tCHANGED\t$url\tEOL3\n";
	exit 0;
}

print "OK\t$url\tNOT_CHANGED\tCODE=$code\tEOL4\n";


