package MyBlog::Markdown;

use Text::Markdown 'markdown';
use Template::Plugin::Filter;
use base qw( Template::Plugin::Filter );
use strict;
use warnings;

sub init {
  my $self = shift;
  $self -> install_filter("markdown");
  return $self;
}

sub filter {
  my ($self, $text) = @_;
  return markdown($text);
}

# module OK
1;

