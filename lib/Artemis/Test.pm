package Artemis::Test;

use warnings;
use strict;

our $VERSION = '2.010006';

use 5.010;

use Test::More;

use parent 'Exporter';
our @EXPORT = qw/artemis_suite_meta artemis_section_meta/;

sub _uname {
        my $uname = `uname -a`;
        chomp $uname;
        return $uname;
}

sub _hostname {
        my $hostname = `hostname`;
        chomp $hostname;
        return $hostname;
}

sub _osname {
        my $osname = `cat /etc/issue.net | head -1`;
        chomp $osname;
        return $osname;
}

sub _cpuinfo {
        my @cpus      = map { chomp; s/^\s*//; $_ } `grep 'model name' < /proc/cpuinfo | cut -d: -f2-`;
        my %cpu_count = ();
        $cpu_count{$_}++ foreach @cpus;

        my $cpuinfo = join(', ', map { $cpu_count{$_}." cores [$_]" } keys %cpu_count);
        return $cpuinfo;
}

sub _ram {
        my $ram = `free -m | grep -i mem: | awk '{print \$2}'`;
        chomp $ram;
        $ram .= 'MB';
        return $ram;
}

sub _starttime_test_program {
        my $starttime_test_program = `date` ;
        chomp $starttime_test_program;
        return $starttime_test_program;
}

sub _suite_name
{
        my $build_paramfile = '_build/build_params';
        my $makefile        = 'Makefile';

        if (-e $build_paramfile )
        {
                my $params = do $build_paramfile;
                my $suite_name = $params->[2]->{dist_name};
                return $suite_name;
        }
        elsif (-e $makefile)
        {
                my $suite_name = `grep '^DISTVNAME = ' Makefile | head -1 | cut -d= -f2-`;
                chomp $suite_name;
                $suite_name =~ s/^\s*//;
                return $suite_name;
        } else
        {
                die 'Cannot access $build_paramfile or $makefile.\nPlease run perl Build.PL or perl Makefile.PL.';
        }
}

sub _suite_version
{
        my $build_paramfile = '_build/build_params';
        my $makefile        = 'Makefile';

        if (-e $build_paramfile )
        {
                my $params = do $build_paramfile;
                my $suite_version = $params->[2]->{dist_version}->{original};
                return $suite_version;
        }
        elsif (-e $makefile)
        {
                my $suite_version = `grep '^VERSION = ' Makefile | head -1 | cut -d= -f2-`;
                chomp $suite_version;
                $suite_version =~ s/^\s*//;
                return $suite_version;
        }
        else
        {
                die 'Cannot access $build_paramfile or $makefile.\nPlease run perl Build.PL or perl Makefile.PL.';
        }
}

sub _suite_type
{
        'software'; # 'hardware', 'benchmark', 'os', 'unknown'
}

sub _language_description {
        return "Perl $], $^X";
}

sub artemis_suite_meta
{
        my %opts = @_;

        plan tests => 1 unless $opts{-suppress_plan};
        pass("artemis-suite-meta");

        my $suite_name             = $opts{suite_name}             // _suite_name();
        my $suite_version          = $opts{suite_version}          // _suite_version();
        my $suite_type             = $opts{suite_type}             // _suite_type();
        my $hostname               = $opts{hostname}               // _hostname();

        # to be used by TestSuite::* and Artemis::* modules

        print "# Artemis-suite-name:              $suite_name\n";
        print "# Artemis-suite-version:           $suite_version\n";
        print "# Artemis-suite-type:              $suite_type\n";
        print "# Artemis-machine-name:            $hostname\n";

        artemis_section_meta(@_);
}

sub artemis_section_meta
{
        my %opts = @_;

        my $uname                  = $opts{uname}                  // _uname();
        my $osname                 = $opts{osname}                 // _osname();
        my $cpuinfo                = $opts{cpuinfo}                // _cpuinfo();
        my $ram                    = $opts{ram}                    // _ram();
        my $starttime_test_program = $opts{starttime_test_program} // _starttime_test_program();
        my $language_description   = $opts{language_description}   // _language_description();
        my $section                = $opts{section};

        # to be used by TestSuite::* and Artemis::* modules

        print "# Artemis-language-description:    $language_description\n";
        print "# Artemis-uname:                   $uname\n";
        print "# Artemis-osname:                  $osname\n";
        print "# Artemis-cpuinfo:                 $cpuinfo\n";
        print "# Artemis-ram:                     $ram\n";
        print "# Artemis-starttime-test-program:  $starttime_test_program\n";
        print "# Artemis-section:                 $section\n" if $section;
}


=head1 NAME

Artemis::Test - Utilities for testing!

=head1 SYNOPSIS

    use Artemis::Test;
    my $foo = Artemis::Test->new();
    ...

=head1 AUTHOR

OSRC SysInt Team, C<< <osrc-sysint at elbe.amd.com> >>

=head1 COPYRIGHT & LICENSE

Copyright 2008 OSRC SysInt Team, all rights reserved.

This program is released under the following license: restrictive


=cut

1; # End of Artemis::Test
