#
# This file is part of WWW-DaysOfWonder-Memoir44
#
# This software is copyright (c) 2009 by Jerome Quelin.
#
# This is free software; you can redistribute it and/or modify it under
# the same terms as the Perl 5 programming language system itself.
#
use 5.010;
use strict;
use warnings;

package WWW::DaysOfWonder::Memoir44::Utils;
{
  $WWW::DaysOfWonder::Memoir44::Utils::VERSION = '2.120510';
}
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


sub T { return decode('utf8', __($_[0])); }


1;


=pod

=head1 NAME

WWW::DaysOfWonder::Memoir44::Utils - various subs and constants used in the dist

=head1 VERSION

version 2.120510

=head1 DESCRIPTION

This module exports some subs & variables used in the dist.

The following variables are available:

=over 4

=item * $DATADIR

    my $file = $DATADIR->file( ... );

A L<Path::Class> object containing the data directory for the
distribution. This directory will be created if needed.

=back

=head1 METHODS

=head2 my $locstr = T( $string )

Performs a call to C<gettext> on C<$string>, convert it from utf8 and
return the result. Note that i18n is using C<Locale::TextDomain>
underneath, so refer to this module for more information.

=head1 AUTHOR

Jerome Quelin

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Jerome Quelin.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

