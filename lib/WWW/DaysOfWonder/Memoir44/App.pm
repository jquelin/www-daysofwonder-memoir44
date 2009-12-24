use 5.010;
use strict;
use warnings;

package WWW::DaysOfWonder::Memoir44::App;
# ABSTRACT: mem44's App::Cmd

use App::Cmd::Setup -app;

sub allow_any_unambiguous_abbrev { 1 }

1;
__END__

=head1 DESCRIPTION

This is the main application, based on the excellent L<App::Cmd>.
Nothing much to see here, see the various subcommands available for more
information, or run one of the following:

    mem44 commands
    mem44 help

Note that each subcommand can be abbreviated as long as the abbreviation
is unambiguous.
