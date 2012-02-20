#
# This file is part of WWW-DaysOfWonder-Memoir44
#
# This software is copyright (c) 2009 by Jerome Quelin.
#
# This is free software; you can redistribute it and/or modify it under
# the same terms as the Perl 5 programming language system itself.
#
use 5.010;
use strict;
use warnings;

package WWW::DaysOfWonder::Memoir44::App::Command;
{
  $WWW::DaysOfWonder::Memoir44::App::Command::VERSION = '2.120510';
}
# ABSTRACT: base class for sub-commands

use App::Cmd::Setup -command;


# -- public methods


1;


=pod

=head1 NAME

WWW::DaysOfWonder::Memoir44::App::Command - base class for sub-commands

=head1 VERSION

version 2.120510

=head1 DESCRIPTION

This module is the base class for all sub-commands. It doesn't do
anything special currently but trusting methods for pod coverage.

=for Pod::Coverage::TrustPod description
    opt_spec
    execute

=head1 AUTHOR

Jerome Quelin

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Jerome Quelin.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

