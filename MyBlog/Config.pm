package MyBlog::Config;

use Exporter;
use strict;
use warnings;

our @ISA = ('Exporter');
our @EXPORT = ('$TARGET_DIRECTORY', '$VERBOSE');

our $TARGET_DIRECTORY = "/home/pi/public_html/myblog";

our $VERBOSE          = 1;

# module OK
1;


