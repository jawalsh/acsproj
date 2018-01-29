#!/usr/bin/perl

use strict;
use HTTP::Request;
use LWP::UserAgent;
use HTTP::Response;
use URI::Heuristic;

open (FILE, $ARGV[0]) || die "Can't open $ARGV[0]: $!\n";

my $line;
while (defined($line = <FILE>)) {
open (OUT, ">/Users/jawalsh/tmp/$line") || die "Can't open $line. \n";
my $url = "http://wiki.dlib.indiana.edu/confluence/download/attachments/2185/" . $line; # each line is a URL to the RDF file
# URL to the W3C validator
#my $validateUrl="http://www.w3.org/RDF/Validator/ARPServlet?URI=$url&PARSE=Parse+URI%3A+&TRIPLES_AND_GRAPH=PRINT_TRIPLES&FORMAT=PNG_EMBED";
#printf "%s =>\n\t", $url;
my $ua = LWP::UserAgent->new();
$ua->agent("Schmozilla/v9.14 Platinum");
my $req = HTTP::Request->new(GET=>$url);
my $response = $ua->request($req);
if ($response->is_error()) {
printf " %s\n", $response->status_line;
} else {
my $content = $response->content();
print OUT $content;
close OUT;
}
}
