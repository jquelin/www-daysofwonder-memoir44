use 5.010;
use strict;
use warnings;

package WWW::DaysOfWonder::Memoir44::Utils;
# ABSTRACT: various subs and constants used in the dist

use File::HomeDir::PathClass;
use Exporter::Lite;

our @EXPORT_OK = qw{ $DATADIR };


# -- public vars

our $DATADIR = File::HomeDir::PathClass->my_dist_data(
        'WWW-DaysOfWonder-Memoir44', { create => 1 } );

# -- public subs

1;
__END__

=head1 DESCRIPTION

This module exports some subs & variables used in the dist.

The following variables are available:

=over 4

=item * $DATADIR

    my $file = $DATADIR->file( ... );

A L<Path::Class> object containing the data directory for the
distribution. This directory will be created if needed.

=back


