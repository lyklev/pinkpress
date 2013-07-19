package MyBlog::PageReader;

use MyBlog::Config;
use MyBlog::Post;
use Time::Local;
use strict;
use warnings;

   
sub by_timestamp_desc {
  $b -> {TIME} <=> $a -> {TIME};
}

sub read_page_metadata {
  # TODO: read the source directory from configuration
  my @page_files = <pages/*.txt>;
  my @pages;
  for my $page_file (@page_files) {
    push (@pages, new MyBlog::Post($page_file));
  } # next page file
  return sort by_timestamp_desc @pages;
}

# module Ok
1;
  
