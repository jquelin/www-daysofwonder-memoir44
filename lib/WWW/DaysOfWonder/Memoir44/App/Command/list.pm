use 5.010;
use strict;
use warnings;

package WWW::DaysOfWonder::Memoir44::App::Command::list;
# ABSTRACT: list scenarios according to various criterias

use Encode qw{ encode };

use WWW::DaysOfWonder::Memoir44::App -command;
use WWW::DaysOfWonder::Memoir44::DB::Scenarios;


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
    foreach my $expansion ( qw{ tp ef pt mt ap } ) {
        next unless defined $opts->{$expansion};
        my $clause = '$_->need_';
        $clause    = "!$clause" unless $opts->{$expansion};
        push @clauses, $clause . $expansion;
    }
    my $grep = "sub { " . join(" & ", (1,@clauses)) . " }";
    $grep = eval $grep;
    my $db = WWW::DaysOfWonder::Memoir44::DB::Scenarios->instance;
    $db->read;


    my @scenarios = $db->grep( $grep );

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
