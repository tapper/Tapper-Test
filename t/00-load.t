#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'Tapper::Test' );
}

diag( "Testing Tapper::Test $Tapper::Test::VERSION, Perl $], $^X" );
