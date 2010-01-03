use 5.010;
use strict;
use warnings;

package WWW::DaysOfWonder::Memoir44::App::Command::update;
# ABSTRACT: update db from dow website

use LWP::UserAgent;

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

    # the user agent will be reused
    my $ua = LWP::UserAgent->new;
    $ua->agent('');
    $ua->env_proxy;

    # remove all existing scenarios from db
    WWW::DaysOfWonder::Memoir44::DB::Scenario->delete('');

    foreach my $source ( qw{ game approved public } ) {
        my $url = WWW::DaysOfWonder::Memoir44::Url->new({source=>$source});
        say "* updating $source scenarios";
        say "- url: $url";

        print "- downloading url: ";
        my $response = $ua->get("$url");
        die $response->status_line unless $response->is_success;
        say "done";

        die;
    }
}


1;
__END__

=for Pod::Coverage::TrustPod
    description
    opt_spec
    execute

=head1 DESCRIPTION

This command updates the database of scenarios available from days of
wonder website.

