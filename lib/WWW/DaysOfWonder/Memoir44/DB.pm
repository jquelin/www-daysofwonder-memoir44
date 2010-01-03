use 5.010;
use strict;
use warnings;

package WWW::DaysOfWonder::Memoir44::DB;
# ABSTRACT: orlite for mem44 sqlite db

use File::Spec::Functions qw{ catdir };

use WWW::DaysOfWonder::Memoir44::Utils qw{ get_db_file get_dist_dir };

use ORLite ();
use ORLite::Migrate {
    create        => 1,
    file          => get_db_file(),
    user_revision => 1,
    timeline      => catdir( get_dist_dir(), 'db-timeline' ),
}; #, '-DEBUG'; # uncomment the trailing -DEBUG for debug infos on orlite magic


1;
__END__

=for Pod::Coverage::TrustPod
    dsn
    dbh
    commit
    rollback
    do
    selectall_arrayref
    selectall_hashref
    selectcol_arrayref
    selectrow_array
    selectrow_arrayref
    selectrow_hashref
    prepare
    pragma
    begin
    connect
    iterate
    orlite
    sqlite


=head1 DESCRIPTION

This module is used to fetch auto-magically the database schema from the
real sqlite database and map the tables to sub-modules, thanks to
L<ORLite>. It will also create the database if it doesn't exist, with
L<ORLite::Migrate>.

