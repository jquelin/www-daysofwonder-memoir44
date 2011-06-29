use 5.010;
use strict;
use warnings;

package WWW::DaysOfWonder::Memoir44::Types;
# ABSTRACT: various types used in the distribution

use Moose::Util::TypeConstraints;
use Sub::Exporter -setup => { exports => [ qw{ Source } ] };

#enum Board  => qw{ beach country winter desert };
#enum Format => qw{ standard brkthru overlord };
enum Source => qw{ game approved classified public };

1;
__END__

=head1 DESCRIPTION

This module defines and exports the types used by other modules of the
distribution.

The exported types are:

=over 4

=item Source - the scenario source. Can be one of C<game> (shipped with
the board game itself), C<classified> (printed by days of wonders),
C<approved> (officially approved by days of wonder) and C<public>
(provided by other users).

=back
