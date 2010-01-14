use 5.010;
use strict;
use warnings;

package WWW::DaysOfWonder::Memoir44::App::Command::update;
# ABSTRACT: update db from dow website

use HTML::TreeBuilder;
use LWP::UserAgent;
use Term::ProgressBar::Quiet;
use Term::Twiddle::Quiet;
use Text::Trim;

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
    my $twiddle = Term::Twiddle::Quiet->new;

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
        $twiddle->start;
        my $response = $ua->get("$url");
        $twiddle->stop;
        die $response->status_line unless $response->is_success;
        say "done";

        # parse html to find list of scenarios
        print "- parsing: ";
        $twiddle->start;
        my $tree  = HTML::TreeBuilder->new_from_content( $response->content );
        my $table = $tree->find_by_tag_name( 'table' );
        #die $table->dump;
        my $depth = $table->depth;
        my @rows  = $table->look_down(
            '_tag', 'tr',
            sub { $_[0]->depth == $depth+1 },
        );
        shift @rows; # trim title line
        $twiddle->stop;
        say "found ", scalar(@rows), " scenarios";

        # extracting scenarios from table rows
        my $prefix = "- extracting scenarios";
        my $progress = Term::ProgressBar::Quiet->new( {
            count     => scalar(@rows),
            bar_width => 50,
            remove    => 1,
            name      => $prefix,
        } );
        $progress->minor(0);
        foreach my $row ( @rows ) {
            my %data = _scenario_data_from_html_row($row);
            $data{source} = $source;
            my $scenario = WWW::DaysOfWonder::Memoir44::DB::Scenario->new(
                map { $_ => $data{$_} } keys(%data)
            );
            $scenario->insert;
            $progress->update;
        }
        say "${prefix}: done";

        # source complete
        print "\n";
    }
}


#
# my %data = _scenario_data_from_html_row($row);
#
# given a $row of the table fetched from dow website, parse it and
# return a hash with all scenario properties extracted. the hash
# keys are:
#  - id:        id of the scenario
#  - name:      scenario name
#  - operation: operation the scenario is part of
#  - front:     west, east, mediterranean, etc.
#  - author:    who wrote the scenario
#  - rating:    average scenario rating (1, 2 or 3)
#  - updated:   date of last scenario update
#  - format:    standard, overlord, breakthru
#  - board:     country, beach, winter, desert
#  - need_tp:   whether terrain pack is needed
#  - need_ef:   whether eastern front is needed
#  - need_mt:   whether mediterranean theater is needed
#  - need_pt:   whether pacific theater is needed
#  - need_ap:   whether air pack is needed
#  - need_bm:   whether battle maps is needed
#  - need_cb:   whether campaign book is needed
#
sub _scenario_data_from_html_row {
    my $row = shift;
    my %data;

    # split row in cells
    my $depth = $row->depth;
    my @cells = $row->look_down(
        '_tag', 'td',
        sub { $_[0]->depth == $depth+1 },
    );

    # extract values and fill in the hash
    my $link = $cells[9]->find_by_tag_name('a')->attr('href');
    ($data{id}) = ($link =~ /id=(\d+)/);
    $data{name}      = trim($cells[0]->as_text);
    $data{operation} = trim($cells[2]->as_text);
    $data{front}     = trim($cells[3]->as_text);
    $data{author}    = trim($cells[4]->as_text);
    $data{rating}    = substr $cells[6]->find_by_tag_name('img')->attr('alt'), 0, 1;

    my $updated = trim($cells[5]->as_text);                    # dd/mm/yyyy
    $data{updated}   = join '-', reverse split /\//, $updated; # yyyy-mm-dd

    # fill in booleans
    my @subcells = $cells[8]->find_by_tag_name('td');
    my $boardimg = $subcells[2]->find_by_tag_name('img')->attr('src');
    $boardimg =~ /mm_board_([^_]+)_([^.]+)\.gif/
        or die "unknwon board image: $boardimg";
    $data{format} = $1;
    $data{board}  = $2;
    my @imgs =
        map { $_->attr('src') }
        $subcells[3]->find_by_tag_name('img');
    $data{need_tp} = grep { /pack_terrain/ } @imgs;
    $data{need_ef} = grep { /pack_eastern/ } @imgs;
    $data{need_pt} = grep { /pack_pacific/ } @imgs;
    $data{need_mt} = grep { /pack_mediterranean/ } @imgs;
    $data{need_ap} = grep { /pack_air/ } @imgs;
    $data{need_bm} = 0; # grep { /pack_/ } @imgs;
    $data{need_cb} = 0; # grep { /pack_/ } @imgs;

    return %data;
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

