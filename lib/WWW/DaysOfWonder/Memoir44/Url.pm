use 5.010;
use strict;
use warnings;

package WWW::DaysOfWonder::Memoir44::Url;
# ABSTRACT: encapsulation of days of wonder urls

use Moose;
use MooseX::Has::Sugar;
use URI;

use overload q{""} => 'as_string';


# -- attributes

=attr $url->source;

The scenarios source. See the C<Source> type in
L<WWW::DaysOfWonder::Memoir44::Types>.

=cut

has source => ( ro, isa=>'Str', required   );
has _uri   => ( ro, isa=>'URI', lazy_build, handles=>['as_string'] );


# -- initializers & builders

sub _build__uri {
    my $self = shift;
    my $uri  = URI->new;
    $uri->scheme( 'http' );
    $uri->host( 'www.daysofwonder.com' );
    $uri->path( '/memoir44/en/scenario_list/' );

    # canonical url:
    # http://www.daysofwonder.com/memoir44/en/scenario_list/?&start=0&page_limit=2000
    # other valid http options:
    #   status      game = shipped, approved = official, public = non-dow, classified = restricted
    #   selpack_tp  terrain pack
    #   selpack_ef  east front
    #   selpack_pt  pacific theater
    #   selpack_ap  air pack
    #   selpack_mt  mediterranean theater
    #   selpack_bm  battle map
    #   selpack_cb  carnets campagne
    # with values: 0 = undef, 1 = with, 2 = without
    # eg: selpack_tp=1&selpack_ef=2
    my %options = (
        start      => 0,
        page_limit => 2000,
        status     => $self->source,
    );

    $uri->query_form( \%options );
    return $uri;
}


# -- public methods

=method my $str = $url->as_string;

Stringifies the object in a well-formed url. This is the method called
when the object needs to be stringified by perl due to the context.

=cut

# handled by _uri attribute


1;
__END__

=head1 SYNOPSIS

    use WWW::DaysOfWonder::Memoir44::Url;
    my $url = WWW::DaysOfWonder::Memoir44::Url->new( { source => 'game' } );
    print $url;


=head1 DESCRIPTION

This module encapsulates urls to fetch scenarios from Days of Wonder.
Depending on various criterias (cf attributes), the url listing the
available scenarios will be different.

