use 5.012;
use strict;
use warnings;

package WWW::DaysOfWonder::Memoir44::DB::Scenarios;
# ABSTRACT: scenarios database

use DateTime;
use MooseX::Singleton;
use MooseX::Has::Sugar;
use Path::Class;
use Storable qw{ nstore retrieve };

use WWW::DaysOfWonder::Memoir44::DB::Params;
use WWW::DaysOfWonder::Memoir44::Utils qw{ $DATADIR };


my $dbfile = $DATADIR->file( "scenarios.store" );

has scenarios => (
    rw, auto_deref,
    traits     => ['Array'],
    isa        => 'ArrayRef[WWW::DaysOfWonder::Memoir44::Scenario]',
    default    => sub { [] },
    writer     => '_set_scenarios',
    handles    => {
        nb_scenarios  => 'count',     # my $nb = $db->nb_scenarios;
        add           => 'push',      # $db->add( $scenario, $scenario );
        clear         => 'clear',     # $db->clear;
        grep          => 'grep',      # $db->grep( sub { $_->need_ef });
    }
);


 # -- public methods
  
=method add

    my $db = WWW::DaysOfWonder::Memoir44::DB::Scenarios->instance;
    $db->add( @scenarios );

Store a new scenario in the scenarios database.

=cut

# implemented by the 'Array' trait of the 'scenarios' attribute.


=method clear

    my $db = WWW::DaysOfWonder::Memoir44::DB::Scenarios->instance;
    $db->clear;

Remove all scenarios from the database.

=cut

# implemented by the 'Array' trait of the 'scenarios' attribute.


=method read

    my $db = WWW::DaysOfWonder::Memoir44::DB::Scenarios->read;

Read the whole scenarios database from a file. The file is internal to
the distrib, and stored in a private directory.

=cut

sub read {
    my $self = shift;

    my $scenarios_ref = retrieve( $dbfile->stringify );
    $self->_set_scenarios( $scenarios_ref );
}


=method write

    my $db = WWW::DaysOfWonder::Memoir44::DB::Scenarios->instance;
    $db->write;

Store the whole scenarios database to a file. The file is internal to
the distrib, and stored in a private directory.

=cut

sub write {
    my $self = shift;
    my @scenarios = $self->scenarios;
    nstore( \@scenarios, $dbfile->stringify );

    # store timestamp
    my $params = WWW::DaysOfWonder::Memoir44::DB::Params->instance;
    my $today  = DateTime->today->ymd;
    $params->set( last_updated => $today );
}

1;
__END__

=head1 SYNOPSIS

    my $db = WWW::DaysOfWonder::Memoir44::DB::Scenarios->instance;
    $db->read;
    my @top_scenarios = $db->grep( sub { $_->rating == 3 } );
    $db->clear;
    $db->add( @top_scenarios );
    $db->write;


=head1 DESCRIPTION

This class implements a singleton holding all the scenarios available.
It is the core of the whole distribution.

