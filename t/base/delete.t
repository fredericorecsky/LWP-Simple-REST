#!/usr/bin/perl -w
#
# Check DELETE via HTTP
#

print "1..2\n";

require "config/net.pl";

use LWP::Simple::REST qw/http_delete/;

$srv = $net::httpserver;
$script = $net::cgidir . "/test";

$url = "http://$srv$script";

print "DELETE $url\n\n";

my $response = http_delete($url, ( test =>  1, del => 0 ) );

my $str = $response->as_string;

print "$str\n";

if ($response->is_success and $str =~ /^REQUEST_METHOD=DELETES/m){
    print "ok 1\n";
}
else{
    print "not ok 1\n";
}

if ($str =~ /^CONTENT_LENGTH=(\d+)$/m){
    print "ok 2\n";
}
else{
    print "not ok 2\n";
}

#avoid -w warning
$dummy = $net::httpserver;
$dummy = $net::cgidir;
