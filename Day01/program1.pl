#!/usr/bin/perl -w

use strict;
use warnings;

my $fd;

open($fd, '<', "input1.txt") || die "Could not open input for reading";

my $pos = 50;
my $count = 0;

while (my $line = <$fd>)
{
    if ($line =~ /R(\d+)/)
    {
        $pos += $1;
    }
    elsif ($line =~ /L(\d+)/)
    {
        $pos -= $1;
    }

    $pos = $pos % 100;

    if ($pos == 0)
    {
        $count++;
    }

    # print "Current position: $pos\n";
}

print "Number of times at position 0: $count\n";

close($fd);
