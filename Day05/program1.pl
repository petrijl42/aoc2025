#!/usr/bin/perl -w

use strict;
use warnings;

my $fd;

open($fd, '<', "input1.txt") || die "Could not open input for reading";

my $count = 0;
my $fresh_ranges = [];

while (my $line = <$fd>)
{
    chomp($line);

    last if ($line eq '');

    my ($start, $end) = split('-', $line);
    push @$fresh_ranges, { start => $start, end => $end };
}

while (my $line = <$fd>)
{
    chomp($line);

    my $id = int($line);

    if (is_fresh($id, $fresh_ranges))
    {
        $count++;
    }
}

print "Count: $count\n";

close($fd);

sub is_fresh
{
    my $id = shift;
    my $fresh_ranges = shift;

    foreach my $range (@$fresh_ranges)
    {
        if ($id >= $range->{start} && $id <= $range->{end})
        {
            return 1;
        }
    }

    return 0;
}