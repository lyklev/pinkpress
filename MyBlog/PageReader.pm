package MyBlog::PageReader;

use MyBlog::Config;
use Time::Local;
use strict;
use warnings;

sub parse_timestamp {
  my $timestamp = shift;
  if ($timestamp =~ m/(\d{4})-(\d\d)-(\d\d) (\d\d):(\d\d):?(\d\d)?/) {
    return timelocal($6 // 0, $5, $4, $3, $2 - 1, $1);
  }
  else {
    return 0;
  }
}
    
sub by_timestamp_desc {
  parse_timestamp($b -> {TIMESTAMP}) <=> parse_timestamp($a -> {TIMESTAMP});
}

sub read_page_metadata {
  # TODO: read the source directory from configuration
  my @page_files = <pages/*.txt>;
  my @pages;
  for my $page_file (@page_files) {
    unless (open(PAGE, "<", $page_file)) {
      print(STDERR "*** WARNING: could not open '$page_file'\n");
      next;
    }
    print("[INFO]: processing $page_file\n");
    
    my $page_metadata = {
      'FILE'      => $page_file,
      'TITLE'     => undef,
      'TIMESTAMP' => undef,
      'EXCERPT'   => undef,
    };

    # first, read the title and the timestamp
    while (my $line = <PAGE>) {
      chomp $line;
      $line =~ s/\s*$//; # strip trailing whitespace
     
      last if $line eq 'CONTENT';    # stop reading
      if ($line =~ /^(\w+): *(.*)$/ && exists $page_metadata->{$1}) {
        $page_metadata->{$1} = $2;
      }
    }

    # read the first paragraph, use it as an except
    my $excerpt = "";
    while (my $line = <PAGE>) {
      chomp $line;
      $line =~ s/\s*$//; # strip trailing whitespace
      last if $line =~ m/^>>>$/;

      $excerpt .= $line;
      $excerpt .= "\n";
    }

    $page_metadata->{'EXCERPT'} = $excerpt;

    close(PAGE);

    push(@pages, $page_metadata);

  } # next page file
  return sort by_timestamp_desc @pages;
}

# module Ok
1;
  
