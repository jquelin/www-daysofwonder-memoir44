use 5.012;
use strict;
use warnings;

package WWW::DaysOfWonder::Memoir44::Filter;
# ABSTRACT: filter object

use Moose;
use MooseX::Has::Sugar;
use MooseX::SemiAffordanceAccessor;

with 'MooseX::Getopt::GLD';


use WWW::DaysOfWonder::Memoir44::Types;


# -- public attributes

=attr ids

Scenario id (if multiple entries, only one of them need to match).
Alias: C<i>.

=attr name

Scenario name. Alias: C<n>.

=attr operation

Scenario operation. Alias: C<o>.

=attr format

Scenario format. Aliases: C<fmt> or C<f>.

=attr board

Scenario board. Alias: C<b>.

=cut

has ids => (
    rw, auto_deref,
    isa           => 'ArrayRef[Int]',
    predicate     => 'has_ids',
    traits        => [ qw{ Getopt } ],
    cmd_aliases   => [ qw{ i } ],
);

has name => (
    rw,
    isa           => 'Str',
    predicate     => 'has_name',
    traits        => [ qw{ Getopt } ],
    cmd_aliases   => [ qw{ n } ],
);

has operation => (
    rw,
    isa           => 'Str',
    predicate     => 'has_operation',
    traits        => [ qw{ Getopt } ],
    cmd_aliases   => [ qw{ o } ],
);

has format => (
    rw,
    isa           => 'Format',
    predicate     => 'has_format',
    traits        => [ qw{ Getopt } ],
    cmd_aliases   => [ qw{ fmt f } ],
);

has board => (
    rw,
    isa           => 'Board',
    predicate     => 'has_board',
    traits        => [ qw{ Getopt } ],
    cmd_aliases   => [ qw{ b } ],
);


=attr my $bool = $scenario->tp;

Whether terrain pack extension is required.

=attr my $bool = $scenario->ef;

Whether eastern front extension is required.

=attr my $bool = $scenario->mt;

Whether mediterranean theater extension is required.

=attr my $bool = $scenario->pt;

Whether pacific theater extension is required.

=attr my $bool = $scenario->ap;

Whether air pack extension is required.

=attr my $bool = $scenario->bm;

Whether battle maps extension is required.

=attr my $bool = $scenario->cb;

Whether campaign book extension is required.

=cut

has tp   => ( rw, isa=>'Bool' );
has ef   => ( rw, isa=>'Bool' );
has mt   => ( rw, isa=>'Bool' );
has pt   => ( rw, isa=>'Bool' );
has ap   => ( rw, isa=>'Bool' );
has bm   => ( rw, isa=>'Bool' );
has cb   => ( rw, isa=>'Bool' );


=attr languages

Languages accepted for a scenario (if multiple entries, only one of them
need to match). Aliases: C<lang> or C<l>.

=attr rating

Minimum scenario rating (integer between 0 and 3). Aliases: C<rate> or
C<r>.

=cut

has languages => (
    rw, auto_deref,
    isa           => 'ArrayRef[Str]',
    predicate     => 'has_languages',
    traits        => [ qw{ Getopt } ],
    cmd_aliases   => [ qw{ lang l } ],
);

has rating => (
    rw, coerce,
    isa           => 'Int_0_3',
    predicate     => 'has_rating',
    traits        => [ qw{ Getopt } ],
    cmd_aliases   => [ qw{ rate r } ],
);


# -- public methods

=method as_grep_clause

=cut

sub as_grep_clause {
    my $self = shift;
    my @clauses;

    # ** filtering on scenario information
    # - ids
    if ( $self->has_ids ) {
        my $clause = join( '||', map { "\$_->id == $_" } $self->ids );
        push @clauses, "($clause)";
    }

    # - name
    push @clauses, '$_->name =~ qr{' . $self->name . '}i'
        if $self->has_name;

    # - operation
    push @clauses, '$_->operation =~ qr{' . $self->operation . '}i'
        if $self->has_operation;

    # - format
    push @clauses, '$_->format eq q{' . $self->format . '}'
        if $self->has_format;

    # - board
    push @clauses, '$_->board eq q{' . $self->board . '}'
        if $self->has_board;

    # ** filtering on extensions
    foreach my $expansion ( qw{ tp ef pt mt ap } ) {
        next unless defined $self->$expansion;
        my $clause = '$_->need_';
        $clause    = "!$clause" unless $self->$expansion;
        push @clauses, $clause . $expansion;
    }

    # ** filtering on meta-information
    # - languages
    if ( $self->has_languages ) {
        my $clause  = 'join(",",$_->languages) =~ /\Q';
        $clause .= join "\\E|\\Q", $self->languages;
        $clause .= '\E/';
        push @clauses, $clause;
    }

    # - rating
    push @clauses, '$_->rating >= ' . $self->rating
        if $self->has_rating;

    my $grep = "sub { " . join(" && ", (1,@clauses)) . " }";
    return eval $grep;
}


1;
__END__

=head1 DESCRIPTION

This module represents a filter that can be applied to the list of
scenarios.

