package MyBlog::Element;

use strict;
use warnings;

sub new {
  my $package = shift;
  my $value   = shift;

  my %options = @_;

  my $self = bless {
    'children'  => [],
    %options,
  }, $package;

  $self -> parse($value);

  return $self;
}

sub add_child {
  my $self = shift;
  my $child = shift;
  push (@{ $self -> {'children'} }, $child);
}

sub to_html {
  my $self = shift;
  
  my $html = "";
  
  for my $child (@{ $self -> {'children'} }) {
    $html .= $child -> to_html();
  }

  return $html;
}

# module OK
1;
