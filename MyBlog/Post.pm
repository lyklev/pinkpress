package MyBlog::Post;

use MyBlog::TimeStamp;
use strict;
use warnings;


sub read_metadata {
  my $self = shift;

  my $filename = $self -> {'FILENAME'};

  unless (open(POST, "<", $filename)) {
    print(STDERR "*** WARNING: could not open '$filename'\n");
    next;
  }
  print("[INFO]: processing $filename\n");

  # first, read the metadata
  while (my $line = <POST>) {
    chomp $line;
    $line =~ s/\s*$//; # strip trailing whitespace
   
    last if $line eq 'CONTENT';    # stop reading
    if ($line =~ /^(\w+): *(.*)$/ && exists $self -> {$1}) {
      $self -> {$1} = $2;
    }
  }

  # read the first paragraph, use it as an except
  my $excerpt = "";
  while (my $line = <POST>) {
    chomp $line;
    $line =~ s/\s*$//; # strip trailing whitespace
    last if $line =~ m/^>>>$/;

    $excerpt .= $line;
    $excerpt .= "\n";
  }

  $self -> {'EXCERPT'} = $excerpt;

  close(POST);
  
  return $self;
}

sub new {
  my $package = shift;
  my $filename = shift;

  my $self = bless {
    'FILENAME'  => $filename,
    'TITLE'     => undef,
    'TIMESTAMP' => undef,
    'EXCERPT'   => undef,
  }, $package;

  $self -> read_metadata();

  $self -> {TIME} = new MyBlog::TimeStamp($self -> {TIMESTAMP});

  return $self;
}

sub time {
  my $self = shift;
  return $self -> {TIME} -> {TIME};
}

# module OK
1;
