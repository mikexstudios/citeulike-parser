#!/usr/bin/env perl

use warnings;
use LWP::Simple;
#use LWP::UserAgent;


#my $ua = LWP::UserAgent->new;

$url = "http://highwire.stanford.edu/lists/allsites.dtl";
$source = get("$url") || (print "status\terr\t (1) Could not retrieve information from the journal page\n" and exit);

#print "$source" and exit;


while ($source =~ m/http:\/\/([\w.-]+)/g)	 
	{
	$match = $1;
	unless ($match =~ m/highwire.stanford.edu/g | $match =~ m/google/g) # | $match =~ m/sagepub/g | $match =~ m/oxfordjournals/g)
		{
		print "$match\n";	
		}
	}






