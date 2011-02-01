use 5.010;
use strict;
use warnings;

package WWW::DaysOfWonder::Memoir44::Utils;
# ABSTRACT: various subs and constants used in the dist

use Encode;
use Exporter::Lite;
use File::HomeDir::PathClass;
use Locale::TextDomain          'WWW-DaysOfWonder-Memoir44';

our @EXPORT_OK = qw{ $DATADIR T };


# -- public vars

our $DATADIR = File::HomeDir::PathClass->my_dist_data(
        'WWW-DaysOfWonder-Memoir44', { create => 1 } );


# -- public subs

=method my $locstr = T( $string )

Performs a call to C<gettext> on C<$string>, convert it from utf8 and
return the result. Note that i18n is using C<Locale::TextDomain>
underneath, so refer to this module for more information.

=cut

sub T { return decode('utf8', __($_[0])); }


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


