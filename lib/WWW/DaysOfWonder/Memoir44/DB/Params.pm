use 5.012;
use strict;
use warnings;

package WWW::DaysOfWonder::Memoir44::DB::Params;
# ABSTRACT: various runtime params

use Config::Tiny;
use MooseX::Singleton;
use MooseX::Has::Sugar;

use WWW::DaysOfWonder::Memoir44::Utils qw{ $DATADIR };


my $params_file = $DATADIR->file( "params.ini" );

has _params => ( ro, isa => "Config::Tiny", lazy_build );

sub _build__params {
    my $self = shift;
    my $params = Config::Tiny->read( $params_file );
    $params  //= Config::Tiny->new;
    return $params;
}

# -- public methods

=method get

    my $value = $params->get( $key );

Return the value associated to C<$key> in the wanted section.

=cut

sub get {
    my ($self, $key) = @_;
    my $section = scalar caller;
    return $self->_params->{ $section }->{ $key };
}


=method set

    $params->set( $key, $value );

Store the C<$value> associated to C<$key> in the wanted section.

=cut

sub set {
    my ($self, $key, $value) = @_;
    my $section = scalar caller;
    my $params = $self->_params;
    $params->{ $section }->{ $key } = $value;
    $params->write( $params_file );
}


1;
__END__

=head1 SYNOPSIS

    my $params = WWW::DaysOfWonder::Memoir44::DB::Params->instance;
    my $value  = $params->get( $key );
    $params->set( $key, $value );


=head1 DESCRIPTION

This module allows to store various runtime parameters.

It implements a singleton responsible for automatic retrieving & saving
of the various information. Each module gets its own section, so keys
won't be over-written if sharing the same name accross package.

