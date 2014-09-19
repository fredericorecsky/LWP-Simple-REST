#!/usr/bin/perl -w
#
# Check POST via HTTP
#

print "1..2\n";

require "config/net.pl";
use LWP::Simple::REST qw/http_post/;

$srv = $net::httpserver;
$script = $net::cgidir . "/test";

$url = "http://$srv$script";
#$url = "http://localhost:80/test";

print "POST $url\n\n";

my $response = http_post($url, ( searchtype => 'Substring' ));

my $str = $response->as_string;
#my $str = $response;

print "$str\n";

if ($response->is_success and $str =~ /^REQUEST_METHOD=POSTS/m){
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
