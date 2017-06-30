#!/usr/bin/env perl

# Sane defaults
require 5.004;
use strict 'vars';
use warnings;
use diagnostics;
use feature qw/say/;

# Stadard libaries
use DBI;
use Data::Dumper;

# Setup local library path
use File::Basename;
use lib dirname( __FILE__ );

# Code starts here
print "\033[2J";   # clear the screen
print "\033[0;0H"; # jump to 0,0

say "Hello from: ", __FILE__;

1;
