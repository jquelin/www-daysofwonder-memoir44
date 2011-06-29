use 5.012;
use strict;
use warnings;

package WWW::DaysOfWonder::Memoir44::Scenario;
# ABSTRACT: scenario object

use Moose;
use MooseX::Has::Sugar;
use Text::Padding;

use overload q{""} => 'as_string';


# -- public attributes

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
has source    => ( rw, isa=>'Source' );
has need_tp   => ( rw, isa=>'Bool' );
has need_ef   => ( rw, isa=>'Bool' );
has need_mt   => ( rw, isa=>'Bool' );
has need_pt   => ( rw, isa=>'Bool' );
has need_ap   => ( rw, isa=>'Bool' );
has need_bm   => ( rw, isa=>'Bool' );
has need_cb   => ( rw, isa=>'Bool' );
has languages => ( rw, isa=>'ArrayRef[Str]', auto_deref );



# -- public methods

=method as_string

    my $str = $scenario->as_string;

Return a line (with a final \n) dumping the scenario and all its
attributes. It is also the method called for stringification, eg when
doing stuff like:

    print $scenario;

=cut

sub as_string {
    my $s = shift;

    my $out = join " ", qw{
        R6id. L38name L34operation
        C13front C8format C7board
        C12author C10source L10updated C3rating_as_star
        L2tp L2ef L2pt L2mt L2ap L8langs
    };
    $out =~ s/([RCL])(\d+)(\w+)/$s->_format($1,$2,$3)/eg;
    return $out;
}

=method tp

=method ef

=method pt

=method mt

=method ap

    my $str = $scenario->tp;
    my $str = $scenario->ef;
    my $str = $scenario->pt;
    my $str = $scenario->mt;
    my $str = $scenario->ap;


Those five methods return either an empty string or the abbreviation of
the expansion depending on the value of the C<need_XX> boolean attribute
of the C<$scenario>. They are useful for display purposes.

=method langs

    my $str = $scenario->langs;

Return a string with existing language versions this scenario separated
by commas. eg C<en,fr>.

=method rating_as_star

    my $str = $scenario->rating_as_star;

Return a string of 0 to 3 stars C<*> depending on the C<rating>
attribute of the C<$scenario>.

=cut

sub langs { my $s=shift; return join ",", $s->languages; }
sub rating_as_star { my $s=shift; '*'x$s->rating; }
sub tp { my $s=shift; $s->need_tp ? 'tp' : ''; }
sub ef { my $s=shift; $s->need_ef ? 'ef' : ''; }
sub pt { my $s=shift; $s->need_pt ? 'pt' : ''; }
sub mt { my $s=shift; $s->need_mt ? 'mt' : ''; }
sub ap { my $s=shift; $s->need_ap ? 'ap' : ''; }


# -- private methods

# $pad should not be re-created for each display
my $pad = Text::Padding->new;
sub _format {
    my ($self, $align, $maxlength, $method) = @_;
    my $str = $self->$method;

    # fill up according to the requirements
    given ( $align ) {
        when ( "L" ) { return $pad->left  ($str, $maxlength); }
        when ( "R" ) { return $pad->right ($str, $maxlength); }
        when ( "C" ) { return $pad->center($str, $maxlength); }
    }
}

1;
__END__

=head1 DESCRIPTION

This module represents a scenario with all its attributes. It implements
L<MooseX::Storage> role, and therefore methods C<pack()> and C<unpack()>
are available.

