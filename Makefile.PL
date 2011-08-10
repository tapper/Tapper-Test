use strict;
use warnings;

use inc::Module::Install;

name     'Tapper-Test';
all_from 'lib/Tapper/Test.pm';
author   'AMD OSRC Tapper Team <tapper@amd64.org>';
license  'freebsd';

build_requires 'Test::Perl::Critic';

author_requires 'Module::Install::WriteAll';

requires 'Test::More' => 0;
requires 'perl'       => '5.010';
requires 'parent';
requires 'Sys::Info';
requires 'Format::Human::Bytes';

repository 'git://github.com/amd/Tapper-Test.git';
bugtracker 'http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Tapper-Test';

WriteAll;

