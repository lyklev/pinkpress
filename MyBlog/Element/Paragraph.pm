package MyBlog::Element::Paragraph;

use MyBlog::Element;
use strict;
use warnings;

our @ISA = qw/MyBlog::Element/;

sub parse {
  my $self = shift;
  my $text = shift;

  $self -> {'text'} = $text;
  return;
}

sub to_html {
  my $self = shift;
  return
    "<p>\n" .
    $self -> {'text'} . 
    "</p>\n";
}

# module OK
1;

