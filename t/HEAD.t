#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;

use LWP::Simple::REST qw/http_head/;
use Test::More;
use Test::Exception;

my @answer = qw(
    text/html
    charset=ISO-8859-1
);

{
    package HTTPTest;
    use base qw/HTTP::Server::Simple::CGI/;

    sub handle_request{
        my $self = shift;
        my $cgi  = shift;



        print "HTTP/1.0 200 OK\r\n";
        print $cgi->header, "text/html; charset=ISO-8859-1";
    }
}

my $server = HTTPTest->new();
my $port = $server->port;
my $server_pid = $server->background();

sleep 2;

my $http_header;
lives_ok {
    $http_header = http_head( "http://localhost:" . $port, { argument1 => "one" } );
    print ref $http_header . "\n\n";
    if ( "HTTP::Headers" ne ref $http_header ) {
        die "not HTTP::Headers";
    }
} 'Request sent';

my @content_type = $http_header->content_type;

is_deeply( \@answer, \@content_type, "Can access header from unblessed headers." );

done_testing();

my $cnt = kill 9, $server_pid;

