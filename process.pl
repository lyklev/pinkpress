#!/usr/bin/perl

use File::Path('make_path');
use Template;
use MyBlog::Config;
use MyBlog::PageReader;
use strict;
use warnings;

# Check if the target directory exists; create if it does not
make_path($TARGET_DIRECTORY);

# Read the page metadata
my @pages = MyBlog::PageReader::read_page_metadata();

# create the output

my $tt = Template->new({
  INCLUDE_PATH  => 'templates',
  PLUGIN_BASE   => 'MyBlog',
  PLUGINS       => {
    'Markdown' => 'MyBlog::Markdown',
  },
});


# create the index page
my $vars = {
  'pages' => \@pages,
};

$tt -> process('index.tt', $vars, $TARGET_DIRECTORY . "/index.html") or
  print($tt -> error());

