#!/usr/bin/perl -w

use strict;
use warnings;

my $fd;

open($fd, '<', "input1.txt") || die "Could not open input for reading";

my $pos = 50;
my $count = 0;

while (my $line = <$fd>)
{
    my $direction;
    my $rotation;

    if ($line =~ /(R|L)(\d+)/)
    {
        $direction = $1;
        $rotation = $2;
    }
    else
    {
        next;
    }

    while ($rotation > 0)
    {
        if ($direction eq 'R')
        {
            $pos += 1;
        }
        elsif ($direction eq 'L')
        {
            $pos -= 1;
        }

        $pos = $pos % 100;
        $count++ if $pos == 0;
        $rotation--;
    }
}

print "Number of times at position 0: $count\n";

close($fd);
