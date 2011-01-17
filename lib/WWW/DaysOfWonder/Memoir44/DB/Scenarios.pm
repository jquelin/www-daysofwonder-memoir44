use 5.012;
use strict;
use warnings;

package WWW::DaysOfWonder::Memoir44::DB::Scenarios;
# ABSTRACT: scenarios database

use MooseX::Singleton;
use MooseX::Has::Sugar;
use Path::Class;
use Storable qw{ nstore retrieve };

use WWW::DaysOfWonder::Memoir44::Utils;


my $dbfile = DATADIR->file( "scenarios.store" );

has scenarios => (
    traits     => ['Array'],
    is         => 'rw',
    isa        => 'ArrayRef[WWW::DaysOfWonder::Memoir44::Scenario]',
    default    => sub { [] },
    auto_deref => 1,
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

    my $db = WWW::DaysOfWonder::Memoir44::DB::Scenarios->new;
    $db->add( @scenarios );

Store a new scenario in the scenarios database.

=cut

# implemented by the 'Array' trait of the 'scenarios' attribute.


=method clear

    my $db = WWW::DaysOfWonder::Memoir44::DB::Scenarios->new;
    $db->clear;

Remove all scenarios from the database.

=cut

# implemented by the 'Array' trait of the 'scenarios' attribute.


=method read

    my $db = WWW::DaysOfWonder::Memoir44::DB::Scenarios->read;

Read the whole scenarios database from a file. The file is internal to
the distrib, no need for you to say where it's located.

=cut

sub read {
    my $self = shift;

    my $scenarios_ref = retrieve( $dbfile->stringify );
    $self->_set_scenarios( $scenarios_ref );
}


=method write

    my $db = WWW::DaysOfWonder::Memoir44::DB::Scenarios->new;
    $db->write;

Store the whole scenarios database to a file. The file is internal to
the distrib, no need for you to say where it's located.

=cut

sub write {
    my $self = shift;
    my @scenarios = $self->scenarios;
    nstore( \@scenarios, $dbfile->stringify );
}

1;
__END__
