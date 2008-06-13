use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new
    (
     module_name         => 'Artemis::Test',
     license             => 'restrictive',
     dist_author         => 'OSRC SysInt Team <osrc-sysint@elbe.amd.com>',
     dist_version_from   => 'lib/Artemis/Test.pm',
     requires => {
                  'perl'                  => '5.010',
                  'Test::More'            => 0,
                  'parent'                => 0,
                  'TAP::Harness::Archive' => 0,
                 },
     add_to_cleanup      => [ 'Artemis-Test-*' ],
     create_makefile_pl => 'traditional',
    );

$builder->create_build_script();
