use 5.010;
use strict;
use warnings;

package WWW::DaysOfWonder::Memoir44::Utils;
# ABSTRACT: various subs and constants used in the dist

use File::HomeDir::PathClass;
use Sub::Exporter -setup => {
    exports => [ qw{ DATADIR } ],
    groups =>  { default => [ qw{ DATADIR } ] },
};



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


1;
__END__

=head1 DESCRIPTION

This module exports various subs used in the dist.
