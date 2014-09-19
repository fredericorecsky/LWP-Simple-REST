#!/usr/bin/perl -w
#
# Check GET via HTTP
#

print "1..2\n";

use Data::Dumper
require "config/net.pl";
use LWP::Simple::REST qw/http_get/;

$srv = $net::httpserver;
$script = $net::cgidir . "/test";

$url = "http://$srv$script?query";
#$url = "http://localhost:80/test";

print "GET $url\n\n";

my $response = http_get($url, ( query => 'test' ));

my $str = $response->as_string;
#my $str = $response;

print "$str\n";

if ($response->is_success and $str =~ /^REQUEST_METHOD=GETS/m){
    print "ok 1\n";
}
else{
    print "not ok 1\n";
}

if ($str =~ /^QUERY_STRING=query$/m){
    print "ok 2\n";
}
else{
    print "not ok 2\n";
}

#avoid -w warning
$dummy = $net::httpserver;
$dummy = $net::cgidir;
