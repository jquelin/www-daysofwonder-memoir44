use 5.010;
use strict;
use warnings;

package WWW::DaysOfWonder::Memoir44::Utils;
# ABSTRACT: various subs and constants used in the dist

use File::BaseDir         qw{ data_home };
use File::Path       2.08 qw{ make_path };
use File::ShareDir        qw{ dist_dir };
use File::Spec::Functions qw{ catdir catfile updir };
use FindBin               qw{ $Bin };
use Sub::Exporter         -setup => { exports => [ qw{
    get_db_file get_dist_dir
} ] };


# -- public subs

=method my $dbpath = get_db_file();

Return the path where the scenarios database will be stored, which will
be by default in a subdir under xdg data_home (cf L<File::BaseDir>).

=cut

sub get_db_file {
    return catfile( _my_data_home(), 'scenarios.db' );
}


=method my $sharedir = get_dist_dir();

Return the path of the private directory where the distribution will
store shared stuff. It can be either found with L<File::ShareDir>, or in
the git checkout if development environment is detected.

=cut

sub get_dist_dir {
    return ( -d catdir( $Bin, updir, '.git' ) )
	? catdir( $Bin, updir, 'share' )
	: dist_dir('WWW-DaysOfWonder-Memoir44');
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
    my $dir = data_home( 'perl', 'WWW-DaysOfWonder-Memoir44' );
    make_path( $dir );
    return $dir;
}


1;
__END__

=head1 DESCRIPTION

This module exports various subs used in the dist. Nothing is exported
by default. Check the list of subs for exported stuff.