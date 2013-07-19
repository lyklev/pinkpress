package MyBlog::Archives;

use strict;
use warnings;

sub compute_archives {
  my @posts = sort {$a -> {TIME} -> {TIME} <=> $b -> {TIME} -> {TIME}} @_;

  my %month_years;

  for my $post (@posts) {
    my $month_year = $post -> {TIME} -> month_year;
    $month_years{$month_year} = $post -> {TIME} -> {TIME};
  }

  return sort { $month_years{$b} <=> $month_years{$a} } keys %month_years;
}

# module OK
1;
