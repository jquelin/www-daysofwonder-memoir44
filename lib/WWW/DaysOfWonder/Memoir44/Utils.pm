use 5.010;
use strict;
use warnings;

package WWW::DaysOfWonder::Memoir44::Utils;
# ABSTRACT: various subs and constants used in the dist

use File::BaseDir         qw{ data_home };
use File::ShareDir        qw{ dist_dir };
use File::Spec::Functions qw{ catfile };
use Readonly;
use Sub::Exporter         -setup => { exports => [ qw{
    $DBFILE $DISTDIR
} ] };

Readonly our $DBFILE  => _get_dbfile_path();
Readonly our $DISTDIR => dist_dir('WWW-DaysOfWonder-Memoir44');

# -- private subs

#
# my $data_home = _my_data_home();
#
# return the directory where all data private to the app will be stored.
# it's in the xdg data_home, then in a perl subdir, then in a subdir
# named after the perl dist.
#
sub _my_data_home {
    return data_home( 'perl', 'WWW-DaysOfWonder-Memoir44' );
}

#
# my $dbpath = _get_dbfile_path();
#
# return the path where the scenarios database will be stored, which
# will be under xdg data_home by default.
#
sub _get_dbfile_path {
    return catfile( _my_data_home(), 'scenarios.db' );
}

1;
__END__

=head1 DESCRIPTION

This module exports various subs and constants used in the dist. Nothing
is exported by default. Here's the list of available exports:

=over 4

=item $DBFILE - the path of the sqlite database where all scenarios are
referenced. cf L<WWW::DaysOfWonder::Memoir44::DB> for more information.

=back
