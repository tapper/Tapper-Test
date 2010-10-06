use strict;
use warnings;

use inc::Module::Install;

name     'Artemis-Test';
all_from 'lib/Artemis/Test.pm';
author   'OSRC SysInt Team <osrc-sysint@elbe.amd.com>';

build_requires 'Test::Perl::Critic';

requires 'Test::More' => 0;
requires 'perl'       => '5.010';
requires 'parent';

WriteAll;

