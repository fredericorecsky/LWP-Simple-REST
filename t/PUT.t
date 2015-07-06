#!/usr/bin/perl

use strict;
use warnings;

use LWP::Simple::REST qw/http_put/;
use Test::More;
use Test::Exception;

my $answer = "argument1=one";

{
    package HTTPTest;
    use base qw/HTTP::Server::Simple::CGI/;

    sub handle_request{
        my $self = shift;
        my $cgi  = shift;

        print "HTTP/1.0 200 OK\r\n";
        print $cgi->header, $answer;
    }

    sub setup {
        
    }
}

my $server = HTTPTest->new();
my $port = $server->port;
my $server_pid = $server->background();

sleep 2;

my $string;

lives_ok {
    $string = http_put( "http://localhost:" . $port, { argument1 => "one" } );
} 'Request sent';

ok( $answer eq $string, "PUT: Answer should be a string" );

done_testing();

my $cnt = kill 9, $server_pid;

