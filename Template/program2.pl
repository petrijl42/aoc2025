#!/usr/bin/perl -w

use strict;
use warnings;

my $fd;

open($fd, '<', "input1.txt") || die "Could not open input for reading";

while (my $line = <$fd>)
{
}

close($fd);
