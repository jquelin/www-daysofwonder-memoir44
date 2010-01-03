use 5.010;
use strict;
use warnings;

package WWW::DaysOfWonder::Memoir44::App::Command::update;
# ABSTRACT: update db from dow website

use WWW::DaysOfWonder::Memoir44::App -command;
use WWW::DaysOfWonder::Memoir44::DB;
use WWW::DaysOfWonder::Memoir44::Url;

sub description {
'Update the database after the list of scenarios from days of wonder
website. This will *not* download the scenarios themselves - see the
download command for this action.';
}

sub opt_spec {
    my $self = shift;
    return;
}

sub execute {
    my $self = shift;

    # remove all existing scenarios from db
    WWW::DaysOfWonder::Memoir44::DB::Scenario->delete('');

    my $url = WWW::DaysOfWonder::Memoir44::Url->new({source=>'game'});
    say "update: $url";
}


1;
__END__

