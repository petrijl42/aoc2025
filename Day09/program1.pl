#!/usr/bin/perl -w

use strict;
use warnings;

my $fd;

open($fd, '<', "input1.txt") || die "Could not open input for reading";

my @coords;

while (my $line = <$fd>)
{
    chomp($line);
    my ($x, $y) = split(/,/, $line);
    push(@coords, { x => $x, y => $y });
}

close($fd);

my $max_area = 0;

for (my $i = 0; $i < @coords; $i++)
{
    my $coord1 = $coords[$i];

    for (my $j = $i + 1; $j < @coords; $j++)
    {
        my $coord2 = $coords[$j];

        my $dx = abs($coord1->{x} - $coord2->{x}) + 1;
        my $dy = abs($coord1->{y} - $coord2->{y}) + 1;
        my $area = $dx * $dy;

        if ($area > $max_area) {
            $max_area = $area;
        }
    }
}

print "Maximum area between any two coordinates: $max_area\n";
