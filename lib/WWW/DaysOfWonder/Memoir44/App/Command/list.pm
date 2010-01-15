use 5.010;
use strict;
use warnings;

package WWW::DaysOfWonder::Memoir44::App::Command::list;
# ABSTRACT: list scenarios according to various criterias

use Encode qw{ encode };

use WWW::DaysOfWonder::Memoir44::App -command;
use WWW::DaysOfWonder::Memoir44::DB;


# -- public methods

sub description {
'List the scenarios available in the database according to various
criterias. The database must exist - see the update command for
this action.';
}

sub opt_spec {
    my $self = shift;
    return (
        [],
        [ 'list only scenario that need extension:' ],
        [ 'tp!' => 'terrain pack          (--notp to negate)' ],
        [ 'ef!' => 'east front            (--noef to negate)' ],
        [ 'pt!' => 'pacific theater       (--nopt to negate)' ],
        [ 'mt!' => 'mediterranean theater (--nomt to negate)' ],
        [ 'ap!' => 'air pack              (--noap to negate)' ],
    );
}

sub execute {
    my ($self, $opts, $args) = @_;

    # prepare the filter
    my @clauses;
    push @clauses, "need_tp = $opts->{tp}" if defined $opts->{tp};
    push @clauses, "need_ef = $opts->{ef}" if defined $opts->{ef};
    push @clauses, "need_pt = $opts->{pt}" if defined $opts->{pt};
    push @clauses, "need_mt = $opts->{mt}" if defined $opts->{mt};
    push @clauses, "need_ap = $opts->{ap}" if defined $opts->{ap};

    # creating filter + fetching matching rows
    my $clauses = scalar(@clauses)
        ? 'WHERE ' . join( ' AND ', @clauses )
        : undef;
    my @scenarios = WWW::DaysOfWonder::Memoir44::DB::Scenario->select($clauses);

    # display the results
    foreach my $s ( @scenarios ) {
        print encode( 'utf-8', $s );
    }
}


1;
__END__


=head1 DESCRIPTION

This command list the scenarios available in the database, according to
various criterias. The database must exist - see the update command for
this action.
