package MyBlog::Element::Div;

use MyBlog::Element;
use MyBlog::Element::Paragraph;
use strict;
use warnings;

our @ISA = qw/MyBlog::Element/;

sub parse {
  my $self = shift;
  my $text = shift;

  my $paragraph = "";
  
  my @lines = split /\n/, $text;      # also removes the newlines
  push(@lines, "");                   # force a last paragraph element

  for my $line (@lines) {
    # remove whitespace
    $line =~ s/^\s*//;
    $line =~ s/\s*$//;

    if ($line eq "") {
      if ($paragraph ne "") {
        $self -> add_child(new MyBlog::Element::Paragraph($paragraph));
        $paragraph = "";
      }
      # else, do nothing
    }
    else {
      $paragraph .= $line . "\n";
    }
  }
  # done parsing
}

sub to_html {
  my $self = shift;

  my $div_str;
  if (exists $self -> {'class'}) {
    $div_str = '<div class="' . $self -> {'class'} . '">';
  }
  else {
    $div_str = '<div>';
  }

  return 
    $div_str . "\n" .
    $self -> SUPER::to_html() .
    "</div>\n";
}

# module OK
1;

