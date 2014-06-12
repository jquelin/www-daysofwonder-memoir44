use 5.010;
use strict;
use warnings;

package WWW::DaysOfWonder::Memoir44::Types;
# ABSTRACT: various types used in the distribution

use Moose::Util::TypeConstraints;

enum Board  => [ qw{ beach country winter desert } ];
enum Format => [ qw{ standard brkthru overlord } ];
enum Source => [ qw{ game approved classified public } ];

subtype 'Int_0_3',
    as 'Int',
    where   { $_>=0 && $_<=3 },
    message { "Integer should be between 0 and 3\n" };

coerce 'Int_0_3',
    from 'Int',
    via { 0+$_ };

1;
__END__

=head1 DESCRIPTION

This module defines and exports the types used by other modules of the
distribution.

The exported types are:

=over 4

=item Board - the scenario board. Can be one of C<beach>, C<country>,
C<winter> or C<desert>.

=item Format - the scenario format. Can be one of C<standard>,
C<brkthru> or C<overlord>.

=item Int_0_3 - an integer with value 0, 1, 2 or 3.

=item Source - the scenario source. Can be one of C<game> (shipped with
the board game itself), C<classified> (printed by days of wonders),
C<approved> (officially approved by days of wonder) and C<public>
(provided by other users).

=back
