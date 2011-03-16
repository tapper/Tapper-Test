#! /usr/bin/env perl

use strict;
use warnings;
use Test::More;

eval "use Tapper::Test";
plan skip_all => "Tapper::Test not available" if $@;

tapper_suite_meta();
