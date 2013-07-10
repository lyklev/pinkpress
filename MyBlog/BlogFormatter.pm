package MyBlog::ParagraphFormatter;

use Template::Plugin::Filter;
use base qw( Template::Plugin::Filter );
use strict;
use warnings;

sub init {
  my $self = shift;
  $self -> install_filter("paragraph_formatter");
  return $self;
}

sub filter {
  my ($self, $text) = @_;

  my $p = new MyBlog::Element::Paragraph($text);
  return to_html($p);
}

# module OK
1;

