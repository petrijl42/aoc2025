#!/usr/bin/perl -w

use strict;
use warnings;

my $fd;

open($fd, '<', "input1.txt") || die "Could not open input for reading";

my $grid = [];

while (my $line = <$fd>)
{
    chomp $line;
    my @cells = split //, $line;
    push @$grid, \@cells;
}

close($fd);

my $count = 0;
my $found = 0;

do
{
    $found = 0;

    for (my $x = 0; $x < @$grid; $x++)
    {
        for (my $y = 0; $y < @{$grid->[$x]}; $y++)
        {
            if ($grid->[$x]->[$y] eq '@' && count_adjacent($grid, $x, $y, '@') < 4)
            {
                $grid->[$x]->[$y] = '.';
                $count++;
                $found = 1;
            }
        }
    }
}
while ($found);

print "Count: $count\n";

sub count_adjacent
{
    my $grid = shift;
    my $x = shift;
    my $y = shift;
    my $value = shift;

    my $count = 0;

    for (my $dx = -1; $dx <= 1; $dx++)
    {
        for (my $dy = -1; $dy <= 1; $dy++)
        {
            next if ($dx == 0 && $dy == 0);
            my $nx = $x + $dx;
            my $ny = $y + $dy;

            if ($nx >= 0 && $nx < @$grid && $ny >= 0 && $ny < @{$grid->[$nx]})
            {
                if ($grid->[$nx]->[$ny] eq $value)
                {
                    $count++;
                }
            }
        }
    }

    return $count;
}
