#!/usr/bin/perl

use File::Path('make_path');
use Template;
use MyBlog::Config;
use MyBlog::PageReader;
use MyBlog::Archives;
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


# determine the archives
my @archives = MyBlog::Archives::compute_archives(@pages);


# create the index page
my $vars = {
  'pages' => \@pages,
  'archives' => \@archives,
};

print("[INFO]: Generating the index page...\n");

$tt -> process('index.tt', $vars, $TARGET_DIRECTORY . "/index.html") or
  print($tt -> error());

# Copy static content using rsync
print("[INFO]: Copying static content...\n");
system("rsync -r --delete static/* $TARGET_DIRECTORY");

