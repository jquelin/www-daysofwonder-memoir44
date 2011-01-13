use 5.010;
use strict;
use warnings;

package WWW::DaysOfWonder::Memoir44::Utils;
# ABSTRACT: various subs and constants used in the dist

use File::BaseDir         qw{ data_home };
use File::ShareDir        qw{ dist_dir };
use FindBin               qw{ $Bin };
use Path::Class;
use Sub::Exporter         -setup => {
    exports => [ qw{
    get_db_file get_dist_dir DATADIR
} ],
    groups => { default => [ qw{ DATADIR } ] },
};

use File::HomeDir::PathClass;


# -- public subs

=method DATADIR

    my $file = DATADIR->file( ... );

Return a L<Path::Class> object containing the data directory for the
distribution. The directory will be created if needed.

The sub is exported by default.

=cut

sub DATADIR {
    return File::HomeDir::PathClass->my_dist_data(
        'WWW-DaysOfWonder-Memoir44', { create => 1 } );
}


# -- public subs

=method my $dbpath = get_db_file();

Return the path where the scenarios database will be stored, which will
be by default in a subdir under xdg data_home (cf L<File::BaseDir>).

=cut

sub get_db_file {
    my $dir = _my_data_home();
    return $dir->file( 'scenarios.db' )->stringify;
}


=method my $sharedir = get_dist_dir();

Return the path of the private directory where the distribution will
store shared stuff. It can be either found with L<File::ShareDir>, or in
the git checkout if development environment is detected.

=cut

sub get_dist_dir {
    my $dir = dir($Bin);

    # when running tests from build.pl
    return $dir->subdir( 'share' )->stringify if -e $dir->file( 'dist.ini' );

    # when running from development checkout
    $dir = $dir->parent;
    return $dir->subdir( 'share' )->stringify if -e $dir->file( 'dist.ini' );

    # regular usage: using file::sharedir
    return dist_dir('WWW-DaysOfWonder-Memoir44');
}


# -- private subs

#
# my $data_home = _my_data_home();
#
# return the directory where all data private to the app will be stored.
# it's in the xdg data_home, then in a perl subdir, then in a subdir
# named after the perl dist.
#
# the directory will be created if needed.
#
sub _my_data_home {
    my $dir = dir( data_home( 'perl', 'dist', 'WWW-DaysOfWonder-Memoir44' ) );
    $dir->mkpath;
    return $dir;
}


1;
__END__

=head1 DESCRIPTION

This module exports various subs used in the dist.
