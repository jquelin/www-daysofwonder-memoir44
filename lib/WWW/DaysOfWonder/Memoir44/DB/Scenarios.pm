use 5.012;
use strict;
use warnings;

package WWW::DaysOfWonder::Memoir44::DB::Scenarios;
# ABSTRACT: scenarios database

use JSON;
use MooseX::Singleton;
use MooseX::Has::Sugar;
use MooseX::Storage;
use Path::Class;

use WWW::DaysOfWonder::Memoir44::Utils;


with Storage( format => 'JSON', io => 'File' );

my $dbfile = DATADIR->file( "scenarios.json" );

has scenarios => (
    traits     => ['Array'],
    is         => 'ro',
    isa        => 'ArrayRef[WWW::DaysOfWonder::Memoir44::Scenario]',
    default    => sub { [] },
    auto_deref => 1,
    handles    => {
        nb_scenarios => 'count',     # my $nb = $db->nb_scenarios;
        add          => 'push',      # $db->add( $scenario, $scenario );
        clear        => 'clear',     # $db->clear;
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


=method write

    my $db = WWW::DaysOfWonder::Memoir44::DB::Scenarios->instance;
    $db->write;

Store the whole scenarios database to a file.

=cut

sub write {
    my $self = shift;
    $self->store( $dbfile->stringify );
}

1;
__END__
