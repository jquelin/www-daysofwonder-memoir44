use 5.012;
use strict;
use warnings;

package WWW::DaysOfWonder::Memoir44::DB::Params;
# ABSTRACT: various runtime params

use Config::Tiny;
use MooseX::Singleton;
use MooseX::Has::Sugar;

use WWW::DaysOfWonder::Memoir44::Utils qw{ DATADIR };


my $params_file = DATADIR->file( "params.ini" );

has _params => ( ro, isa => "Config::Tiny", lazy_build );

sub _build__params {
    my $self = shift;
    my $params = Config::Tiny->read( $params_file );
    $params  //= Config::Tiny->new;
    return $params;
}

1;
__END__

=head1 SYNOPSIS

    my $params = WWW::DaysOfWonder::Memoir44::DB::Params->instance;
    my $value  = $params->get( $section, $key );
    $params->set( $section, $key, $value );


=head1 DESCRIPTION

This module allows to store various runtime parameters.

It implements a singleton responsible for automatic retrieving & saving
of the various information. It is B<not> responsible for the proper
parameters hierarchy.


