package Tapper::Test;

use warnings;
use strict;

our $VERSION = '3.000004';

use 5.010;

use Test::More;

use parent 'Exporter';
our @EXPORT = qw/tapper_suite_meta tapper_section_meta/;

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
        my @cpus      = map { my $x = $_ ; chomp $x; $x =~ s/^\s*//; $x } `grep 'model name' < /proc/cpuinfo | cut -d: -f2-`;
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
        my $starttime_test_program = `date --rfc-2822` ;
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
                my $suite_name = `grep '^DISTNAME = ' Makefile | head -1 | cut -d= -f2-`;
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
                my $suite_version;
                if (not ref $params->[2]->{dist_version}) {
                        $suite_version = $params->[2]->{dist_version};
                } else {
                        $suite_version = $params->[2]->{dist_version}->{original};
                }
                
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

sub _reportgroup_arbitrary { $ENV{TAPPER_REPORT_GROUP} }
sub _reportgroup_testrun   { $ENV{TAPPER_TESTRUN}   }

sub tapper_suite_meta
{
        my %opts = @_;

        plan tests => 1 unless $opts{-suppress_plan};
        pass("tapper-suite-meta");

        my $suite_name             = $opts{suite_name}             // _suite_name();
        my $suite_version          = $opts{suite_version}          // _suite_version();
        my $suite_type             = $opts{suite_type}             // _suite_type();
        my $hostname               = $opts{hostname}               // _hostname();
        my $reportgroup_arbitrary  = $opts{reportgroup_arbitrary}  // _reportgroup_arbitrary();
        my $reportgroup_testrun    = $opts{reportgroup_testrun}    // _reportgroup_testrun();

        # to be used by TestSuite::* and Tapper::* modules

        print "# Tapper-reportgroup-arbitrary:   $reportgroup_arbitrary\n" if $reportgroup_arbitrary;
        print "# Tapper-reportgroup-testrun:     $reportgroup_testrun\n"   if $reportgroup_testrun;
        print "# Tapper-suite-name:              $suite_name\n";
        print "# Tapper-suite-version:           $suite_version\n";
        print "# Tapper-suite-type:              $suite_type\n";
        print "# Tapper-machine-name:            $hostname\n";

        tapper_section_meta(@_);
}

sub tapper_section_meta
{
        my %opts = @_;

        my $uname                  = $opts{uname}                  // _uname();
        my $osname                 = $opts{osname}                 // _osname();
        my $cpuinfo                = $opts{cpuinfo}                // _cpuinfo();
        my $ram                    = $opts{ram}                    // _ram();
        my $starttime_test_program = $opts{starttime_test_program} // _starttime_test_program();
        my $language_description   = $opts{language_description}   // _language_description();
        my $section                = $opts{section};

        # to be used by TestSuite::* and Tapper::* modules

        print "# Tapper-language-description:    $language_description\n";
        print "# Tapper-uname:                   $uname\n";
        print "# Tapper-osname:                  $osname\n";
        print "# Tapper-cpuinfo:                 $cpuinfo\n";
        print "# Tapper-ram:                     $ram\n";
        print "# Tapper-starttime-test-program:  $starttime_test_program\n";
        print "# Tapper-section:                 $section\n" if $section;
}


=head1 NAME

Tapper::Test - Tapper - Utilities for Perl based Tapper testing

=head1 SYNOPSIS

    use Tapper::Test;
    my $foo = Tapper::Test->new();
    ...

=head1 AUTHOR

AMD OSRC Tapper Team, C<< <tapper at amd64.org> >>

=head1 COPYRIGHT & LICENSE

Copyright 2008-2011 AMD OSRC Tapper Team, all rights reserved.

This program is released under the following license: freebsd


=cut

1; # End of Tapper::Test
