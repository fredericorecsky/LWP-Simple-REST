#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;

use HTTPTest;
use LWP::Simple::REST qw/http_delete/;
use Test::More;
use Test::Exception;

my $expected_answer = "argument1=one";

HTTPTest->answer( $expected_answer );
my $server = HTTPTest->new(3024)->background();

my $string;
lives_ok {
    $string = http_delete( "http://localhost:3024", { argument1 => "one" } );
} 'Request sent';

print Dumper $string;

ok( $expected_answer eq $string, "Answer should be a string" );

done_testing();

my $cnt = kill 9, $server;

