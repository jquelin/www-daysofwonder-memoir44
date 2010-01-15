use 5.010;
use strict;
use warnings;

package WWW::DaysOfWonder::Memoir44::DB::Scenario;
# ABSTRACT: orlite for scenario table in database

=attr my $int = $scenario->id;

Id of the scenario.

=attr my $str = $scenario->name;

Name of the scenario.

=attr my $str = $scenario->operation;

Operation the scenario is part of.

=attr my $date = $scenario->updated;

Date of last scenario update (format C<yyyy-mm-dd>).

=attr my $int = $scenario->rating;

Average scenario rating (1, 2 or 3).

=attr my $str = $scenario->front;

Front where the scenario takes place. Can be West, East,
Mediterranean, etc.

=attr my $str = $scenario->author;

Who wrote the scenario.

=attr my $str = $scenario->board;

Country, beach, winter or desert.

=attr my $str = $scenario->format;

Standard, overlord or breakthru.

=attr my $str = $scenario->source;

Game (bundled with board game), approved (official extensions), public
(all the other).

=attr my $bool = $scenario->need_tp;

Whether terrain pack extension is needed.

=attr my $bool = $scenario->need_ef;

Whether eastern front extension is needed.

=attr my $bool = $scenario->need_mt;

Whether mediterranean theater extension is needed.

=attr my $bool = $scenario->need_pt;

Whether pacific theater extension is needed.

=attr my $bool = $scenario->need_ap;

Whether air pack extension is needed.

=attr my $bool = $scenario->need_bm;

Whether battle maps extension is needed.

=attr my $bool = $scenario->need_cb;

Whether campaign book extension is needed.

=cut

1;
__END__

