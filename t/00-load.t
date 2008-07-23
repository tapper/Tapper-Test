#!perl -T

use Test::More;

plan tests => 1;

BEGIN {
	use_ok( 'Artemis::Test' );
}

diag( "Testing Artemis::Test $Artemis::Test::VERSION, Perl $], $^X" );
