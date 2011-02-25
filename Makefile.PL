use strict;
use warnings;

use inc::Module::Install;

name     'Tapper-Test';
all_from 'lib/Tapper/Test.pm';
author   'OSRC SysInt Team <osrc-sysint@elbe.amd.com>';
license  'freebsd';

build_requires 'Test::Perl::Critic';

author_requires 'Module::Install::WriteAll';

requires 'Test::More' => 0;
requires 'perl'       => '5.010';
requires 'parent';

WriteAll;

