#!/usr/bin/perl -w

use strict;
use warnings;

use List::Util qw(min max);

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
my $lines = get_lines(\@coords);

for (my $i = 0; $i < @coords; $i++)
{
    my $coord1 = $coords[$i];

    for (my $j = $i + 1; $j < @coords; $j++)
    {
        my $coord2 = $coords[$j];

        my $dx = abs($coord1->{x} - $coord2->{x}) + 1;
        my $dy = abs($coord1->{y} - $coord2->{y}) + 1;
        my $area = $dx * $dy;

        next unless ($area > $max_area);
        next unless (is_valid($coord1, $coord2, $lines));

        $max_area = $area;
    }
}

print "Maximum area between any two coordinates: $max_area\n";

sub is_valid
{
    my $coord1 = shift;
    my $coord2 = shift;
    my $lines = shift;

    foreach my $line (@$lines)
    {
        return 0 if (line_in_box($line, $coord1, $coord2));
    }

    return 1;
}


sub line_in_box
{
    my $line = shift;
    my $coord1 = shift;
    my $coord2 = shift;

    my $min_x = min($coord1->{x}, $coord2->{x});
    my $max_x = max($coord1->{x}, $coord2->{x});
    my $min_y = min($coord1->{y}, $coord2->{y});
    my $max_y = max($coord1->{y}, $coord2->{y});

    my $line_min_x = min($line->{x1}, $line->{x2});
    my $line_max_x = max($line->{x1}, $line->{x2});
    my $line_min_y = min($line->{y1}, $line->{y2});
    my $line_max_y = max($line->{y1}, $line->{y2});

    if ($line_max_x <= $min_x || $line_min_x >= $max_x ||
        $line_max_y <= $min_y || $line_min_y >= $max_y)
    {
        return 0;
    }

    return 1;
}


sub get_lines {
    my $coords = shift;
    my $lines = [];

    for (my $i = 0; $i < @$coords; $i++)
    {
        my $coord1 = $coords->[$i-1];
        my $coord2 = $coords->[$i];
        push @$lines, get_line($coord1, $coord2);
    }

    return $lines;
}


sub get_line
{
    my $coord1 = shift;
    my $coord2 = shift;

    return {
        x1 => $coord1->{x},
        y1 => $coord1->{y},
        x2 => $coord2->{x},
        y2 => $coord2->{y},
    };
}
