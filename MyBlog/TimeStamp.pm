package MyBlog::TimeStamp;

use v5.10.1;
use Time::Local;
use strict;
use warnings;

my @months = qw/Januari    Februari    March
                April      May         June
                July       August      September
                October    November    December/;

my @days = qw/Sunday Monday Tuesday Wednesday Thurday Friday Saturday/;

sub th {
  my $mday = shift;

  my $ord = "";

  given ($mday) {
    when( /1$/ ) { $ord = $mday . "st"; }
    when( /2$/ ) { $ord = $mday . "nd"; }
    when( /3$/ ) { $ord = $mday . "rd"; }
    default     { $ord = $mday . "th"; }
  }
  return $ord;
}
  
sub formatted {
  my $self = shift;
  my $timestamp = $self -> {TIME};
  my (undef, $min, $hour, $day, $month, $year, $wday) = timelocal($timestamp);

  my $rep = $days[$wday] . " " . $months[$month] . " " .
            th($day) . " " . $year;
  return $rep;
}

sub new {
  my $package = shift;
  my $timestamp = shift;

  my $time;

  if ($timestamp =~ m/(\d{4})-(\d\d)-(\d\d) (\d\d):(\d\d):?(\d\d)?/) {
    $time = timelocal($6 // 0, $5, $4, $3, $2 - 1, $1);
  }
  else {
    $time = undef;
  }

  my $self = bless {
    TIME => $time,
  }, $package;
  return $self;
}

sub month_year {
  my $self = shift;

  my $timestamp = $self -> {TIME};
  print("'$timestamp'\n");
  my (undef, $min, $hour, $day, $month, $year, $wday) = timelocal($timestamp);

  my $month_year = $months[$month] . " " . $year;
  return $month_year;
}

# module OK
1;
               
