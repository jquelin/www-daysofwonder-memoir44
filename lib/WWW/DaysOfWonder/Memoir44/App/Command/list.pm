use 5.010;
use strict;
use warnings;

package WWW::DaysOfWonder::Memoir44::App::Command::list;
# ABSTRACT: list scenarios according to various criterias

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
    return;
}

sub execute {
    my $self = shift;
    say "list";
}


1;
__END__


=head1 DESCRIPTION

This command list the scenarios available in the database, according to
various criterias. The database must exist - see the update command for
this action.
