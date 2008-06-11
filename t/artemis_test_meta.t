#! /usr/bin/env perl

use strict;
use warnings;

use Test::More tests => 3;
use Artemis::Test;

like ( Artemis::Test::_suite_name(), qr/^Artemis-Test-\d+\.\d+$/,    "suite_name");
like ( Artemis::Test::_ram(),        qr/^\d+MB$/,                    "ram");
like ( Artemis::Test::_uname(),      qr/Linux.*\s+\.*\d+\.\d+\.\d+/, "uname");

