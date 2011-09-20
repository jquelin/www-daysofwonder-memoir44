use 5.010;
use strict;
use warnings;

package WWW::DaysOfWonder::Memoir44::App::Command::list;
# ABSTRACT: list scenarios according to various criterias

use Encode qw{ encode };

use WWW::DaysOfWonder::Memoir44::App -command;
use WWW::DaysOfWonder::Memoir44::DB::Scenarios;
use WWW::DaysOfWonder::Memoir44::Filter;


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
        [ 'scenario information:' ],
        [ 'id|i=i'         => 'scenario id (can be repeated)' ],
        [ 'format|fmt|f=s' => 'scenario format' ],
        [ 'board|b=s'      => 'scenario board'  ],
        [],
        [ 'extensions needed:' ],
        [ 'tp!' => 'terrain pack          (--notp to negate)' ],
        [ 'ef!' => 'east front            (--noef to negate)' ],
        [ 'pt!' => 'pacific theater       (--nopt to negate)' ],
        [ 'mt!' => 'mediterranean theater (--nomt to negate)' ],
        [ 'ap!' => 'air pack              (--noap to negate)' ],
        [],
        [ 'scenario meta-information:' ],
        [ 'rating|r=i'         => 'minimum rating' ],
        [ 'languages|lang|l=s' => 'languages of the scenario (can be repeated)' ],
    );
}

sub execute {
    my ($self, $opts, $args) = @_;

    # prepare the filter
    my $filter = WWW::DaysOfWonder::Memoir44::Filter->new_with_options;
    my $grep   = $filter->as_grep_clause;

    # fetch the scenarios
    my $db = WWW::DaysOfWonder::Memoir44::DB::Scenarios->instance;
    $db->read;
    my @scenarios = $db->grep( $grep );

    # display the results
    foreach my $s ( @scenarios ) {
        say encode( 'utf-8', $s );
    }
}

1;
__END__

=head1 DESCRIPTION

This command list the scenarios available in the database, according to
various criterias. The database must exist - see the update command for
this action.
