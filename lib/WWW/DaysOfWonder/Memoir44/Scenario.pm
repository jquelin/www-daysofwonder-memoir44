use 5.012;
use strict;
use warnings;

package WWW::DaysOfWonder::Memoir44::Scenario;
# ABSTRACT: scenario object

use Moose;
use MooseX::Has::Sugar;
use Perl6::Form;

use overload q{""} => 'as_string';


=attr my $int = $scenario->id;

Id of the scenario.

=attr my $str = $scenario->name;

Name of the scenario.

=attr my $str = $scenario->operation;

Operation the scenario is part of.

=attr my $date = $scenario->updated;

Date of last scenario update (format C<yyyy-mm-dd>).

=attr my $int = $scenario->rating;

Average scenario rating (1, 2 or 3).

=attr my $str = $scenario->front;

Front where the scenario takes place. Can be West, East,
Mediterranean, etc.

=attr my $str = $scenario->author;

Who wrote the scenario.

=attr my $str = $scenario->board;

Country, beach, winter or desert.

=attr my $str = $scenario->format;

Standard, overlord or breakthru.

=attr my $str = $scenario->source;

Game (bundled with board game), approved (official extensions), public
(all the other).

=attr my $bool = $scenario->need_tp;

Whether terrain pack extension is needed.

=attr my $bool = $scenario->need_ef;

Whether eastern front extension is needed.

=attr my $bool = $scenario->need_mt;

Whether mediterranean theater extension is needed.

=attr my $bool = $scenario->need_pt;

Whether pacific theater extension is needed.

=attr my $bool = $scenario->need_ap;

Whether air pack extension is needed.

=attr my $bool = $scenario->need_bm;

Whether battle maps extension is needed.

=attr my $bool = $scenario->need_cb;

Whether campaign book extension is needed.

=cut

has id        => ( rw, isa=>'Int', required );
has name      => ( rw, isa=>'Str', required );
has operation => ( rw, isa=>'Str' );
has updated   => ( rw, isa=>'Str', required );
has rating    => ( rw, isa=>'Int' );
has front     => ( rw, isa=>'Str' );
has author    => ( rw, isa=>'Str' );
has board     => ( rw, isa=>'Str' );
has format    => ( rw, isa=>'Str' );
has source    => ( rw, isa=>'Str' );
has need_tp   => ( rw, isa=>'Bool' );
has need_ef   => ( rw, isa=>'Bool' );
has need_mt   => ( rw, isa=>'Bool' );
has need_pt   => ( rw, isa=>'Bool' );
has need_ap   => ( rw, isa=>'Bool' );
has need_bm   => ( rw, isa=>'Bool' );
has need_cb   => ( rw, isa=>'Bool' );



# -- public methods

=method my $str = $scenario->as_string;

Return a line (with a final \n) dumping the scenario and all its
attributes. It is also the method called for stringification, eg when
doing stuff like:

    print $scenario;

=cut

sub as_string {
    my $s = shift;

    # create the form holding the line definition
    my $form = join ' ',
        '{>>>>}.',                # id
        '{<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<}',  # name
        '{<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<}',      # operation
        '{|||||||||||}',          # front
        '{||||||}',               # format
        '{|||||}',                # board
        '{||||||||||}',           # author
        '{||||||||}',             # source
        '{<<<<<<<<}',             # updated
        '{|}',                    # rating
        '{}',                     # terrain pack
        '{}',                     # east front
        '{}',                     # pacific theater
        '{}',                     # mediterranean theater
        '{}',                     # air pack
        ;

    # return the formatted scenario
    return form $form,
        $s->id, $s->name, $s->operation, $s->front, $s->format, $s->board,
        $s->author, $s->source, $s->updated, '*'x$s->rating,
        $s->need_tp ? 'tp' : '',
        $s->need_ef ? 'ef' : '',
        $s->need_pt ? 'pt' : '',
        $s->need_mt ? 'mt' : '',
        $s->need_ap ? 'ap' : '',
        ;
}

1;
__END__

=head1 DESCRIPTION

This module represents a scenario with all its attributes. It implements
L<MooseX::Storage> role, and therefore methods C<pack()> and C<unpack()>
are available.

